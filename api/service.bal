import ballerina/http;
import ballerina/log;
import ballerina/graphql;

final GlobalDataClient globalDataClient = check new (GLOBAL_DATA_API_URL, clientConfig =
     {
        auth : {
            tokenUrl: CHOREO_TOKEN_URL,
            clientId:GLOBAL_DATA_CLIENT_ID,
            clientSecret:GLOBAL_DATA_CLIENT_SECRET
        }
    }
);


# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # Creates a student applicant Person record
    # + person - the input Person record
    # + return - Student record with persisted data
    resource function post student_applicant(@http:Payload Person person) returns CreateStudentApplicantResponse|error {
        CreateStudentApplicantResponse|graphql:ClientError createStudentApplicantResponse = globalDataClient->createStudentApplicant(person);
        return createStudentApplicantResponse;
    }

    # Creates an ApplicantConsent record
    # Persists the consent record for the given applicant
    # + applicantConsent - the input ApplicantConsent record
    # + return - ApplicantConsentData record with persisted data
    resource function post applicant_consent(@http:Payload ApplicantConsent applicantConsent) returns CreateStudentApplicantConsentResponse|error {
        CreateStudentApplicantConsentResponse|graphql:ClientError createStudentApplicantConsentResponse = globalDataClient->createStudentApplicantConsent(applicantConsent);
        return createStudentApplicantConsentResponse;
    }

    # Creates an Prospect record
    # Persists the contact and consent information for the given prospect
    # + prospect - the input Prospect record
    # + return - Prospect record returned from create operation with persisted data
    resource function post prospect(@http:Payload Prospect prospect) returns Prospect|error {
        CreateProspectResponse|graphql:ClientError createProspectResponse = globalDataClient->createProspect(prospect);
        if(createProspectResponse is CreateProspectResponse) {
            Prospect|error prospect_record = createProspectResponse.add_prospect.cloneWithType(Prospect);
            if(prospect_record is Prospect) {
                return prospect_record;
            } else {
                log:printError("Error while processing Prospect record received", prospect_record);
                return error("Error while processing Prospect record received: " + prospect_record.message() + 
                    ":: Detail: " + prospect_record.detail().toString());
            }
        } else {
            log:printError("Error while creating prospect", createProspectResponse);
            return error("Error while creating prospect: " + createProspectResponse.message() + 
                ":: Detail: " + createProspectResponse.detail().toString());
        }
    }

    # Get vacancies for a named organization 
    # + org_name - the name of the organization to get vacancies for
    # + return - vacancies for the named organization including the sub-org hierarchy
    resource function get organization_vacancies/[string org_name]() returns GetOrganizationVacanciesResponse|error {
        GetOrganizationVacanciesResponse|graphql:ClientError getOrganizationVacanciesResponse = globalDataClient->getOrganizationVacancies(org_name);
        return getOrganizationVacanciesResponse;
    }

    # Get studnet vacancies for a named organization 
    # + org_name - the name of the organization to get vacancies for
    # + return - Student vacancies for the named organization
    resource function get student_vacancies/[string org_name]() returns Vacancy[]|error {
        Vacancy[] vacancy_records = [];
        GetOrganizationVacanciesResponse|graphql:ClientError getOrganizationVacanciesResponse = globalDataClient->getOrganizationVacancies(org_name);
        
        if(getOrganizationVacanciesResponse is GetOrganizationVacanciesResponse) {
             map<json> org_structure = check getOrganizationVacanciesResponse.toJson().ensureType();
             foreach var organizations in org_structure {
                json[]|error org_data = organizations.organizations.ensureType();
                
                if(org_data is json[]) {
                    foreach var data in org_data {
                        json[]|error child_orgs = data.child_organizations.ensureType();
                        if (child_orgs is json[]) {
                            foreach var child_org in child_orgs {
                            
                                json[]|error vacancies =  child_org.vacancies.ensureType();
                                if (vacancies is json[]) {
                                    foreach var vacancy in vacancies {
                                        Vacancy vacancy_record = check vacancy.cloneWithType(Vacancy);
                                        string global_type = vacancy_record?.avinya_type?.global_type?: "";
                                        string foundation_type = vacancy_record?.avinya_type?.foundation_type?: "";
                                        if(global_type.equalsIgnoreCaseAscii("applicant") && 
                                            foundation_type.equalsIgnoreCaseAscii("student")) {
                                            log:printInfo(vacancy_record?.head_count.toString() + "Student vacancies found");
                                            vacancy_records.push(vacancy_record);
                                            return vacancy_records; // assume only one student applicants vacancy block for current cycle of admissions 
                                        }
                                    }
                                } else {
                                    log:printError("Error vacancies: " + vacancies.toString());
                                }
                            }
                        } else {
                            log:printError("Error child_orgs: " + child_orgs.toString());
                        }
                    }
                } else {
                    log:printError("Error org_data: " + org_data.toString());
                }
             } 
        } else {
            return error("Error: student vacancies not found. " + getOrganizationVacanciesResponse.toString());
        }
        return error("Error: student vacancies not found.");
    }
    
}
