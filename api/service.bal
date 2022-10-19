import ballerina/http;
import ballerina/log;
import ballerina/graphql;

final GlobalDataClient globalDataClient = check new ("https://3a907137-52a3-4196-9e0d-22d054ea5789-dev.e1-us-east-azure.choreoapis.dev/mhbw/global-data-graphql-api/1.0.0/graphql");


# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + person - the input Person record
    # + return - Student record with associated data
    resource function post student_applicant(@http:Payload Person person) returns CreateStudentApplicantResponse|error {
        CreateStudentApplicantResponse|graphql:ClientError createStudentApplicantResponse = globalDataClient->createStudentApplicant(person);
        return createStudentApplicantResponse;
    }

    resource function post applicant_consent(@http:Payload ApplicantConsent applicantConsent) returns CreateStudentApplicantConsentResponse|error {
        CreateStudentApplicantConsentResponse|graphql:ClientError createStudentApplicantConsentResponse = globalDataClient->createStudentApplicantConsent(applicantConsent);
        return createStudentApplicantConsentResponse;
    }

    resource function get organization_vacancies/[string name]() returns GetOrganizationVacanciesResponse|error {
        GetOrganizationVacanciesResponse|graphql:ClientError getOrganizationVacanciesResponse = globalDataClient->getOrganizationVacancies(name);
        return getOrganizationVacanciesResponse;
    }

    resource function get student_vacancies/[string name]() returns json|error {
        GetOrganizationVacanciesResponse|graphql:ClientError getOrganizationVacanciesResponse = globalDataClient->getOrganizationVacancies(name);
        // json var = <json>getOrganizationVacanciesResponse;
        if(getOrganizationVacanciesResponse is GetOrganizationVacanciesResponse) {
             map<json> organizations = check getOrganizationVacanciesResponse.ensureType();
             foreach var organization in organizations {
                log:printError(organization.toString());
                map<json>|error child_orgs = organization.child_organizations.ensureType();
                if (child_orgs is map<json>) {
                    foreach var child_org in child_orgs {
                        log:printError(child_org.toString());
                    
                        map<json>|error vacancies =  child_org.vacancies.ensureType();
                        if (vacancies is map<json>) {
                            foreach var vacancy in vacancies {
                                log:printError(vacancy.toString());
                            }
                            return vacancies.toJson();
                        }
                        
                    }
                }
             } 
        } else {
            return error("Error: vacancies not found");
        }
    }
    
}
