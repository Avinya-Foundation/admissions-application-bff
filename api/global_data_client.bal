import ballerina/http;
import ballerina/graphql;
import ballerina/log;

public isolated client class GlobalDataClient {
    final graphql:Client graphqlClient;
    
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig = {}) returns graphql:ClientError? {
        graphql:Client clientEp = check new (serviceUrl, clientConfig);
        self.graphqlClient = clientEp;
        return;
    }

    remote isolated function createAddress(Address address) returns CreateAddressResponse|graphql:ClientError {
        string query = string ` mutation createAddress($address: Address!)
                                {add_address(address:$address){
                                    id
                                }}`;
        map<anydata> variables = {"address": address};
        
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <CreateAddressResponse> check performDataBinding(graphqlResponse, CreateAddressResponse);
    }

    remote isolated function createStudentApplicant(Person person) returns CreateStudentApplicantResponse|graphql:ClientError {
        string query = string `mutation createStudentApplicant($person:Person!) {add_student_applicant(person:$person) {id asgardeo_id jwt_sub_id jwt_email preferred_name full_name sex organization {name {name_en}} phone email permanent_address {street_address city {name {name_en}} phone} mailing_address {street_address city {name {name_en}} phone} notes date_of_birth avinya_type {name active global_type foundation_type focus level} passport_no nic_no id_no}}`;
        map<anydata> variables = {"person": person};
        
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <CreateStudentApplicantResponse> check performDataBinding(graphqlResponse, CreateStudentApplicantResponse);
    }

    remote isolated function getOrganizationVacancies(string name) returns GetOrganizationVacanciesResponse|graphql:ClientError {
        string query = string `query getOrganizationVacancies($name:String!) {organization_structure(name:$name) {organizations {name {name_en} address {street_address} avinya_type {name active global_type foundation_type focus level} phone child_organizations {name {name_en} vacancies {name description head_count avinya_type {name active global_type foundation_type focus level} evaluation_criteria {id prompt description difficulty evalualtion_type rating_out_of answer_options {answer}}}} parent_organizations {name {name_en}} vacancies {name description head_count}}}}`;
        map<anydata> variables = {"name": name};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <GetOrganizationVacanciesResponse> check performDataBinding(graphqlResponse, GetOrganizationVacanciesResponse);
    }

    remote isolated function createStudentApplicantConsent(ApplicantConsent consent) returns CreateStudentApplicantConsentResponse|graphql:ClientError {
        string query = string `mutation createStudentApplicantConsent($consent:ApplicantConsent!) {add_student_applicant_consent(applicantConsent:$consent) {name date_of_birth done_ol ol_year distance_to_school phone email information_correct_consent agree_terms_consent}}`;
        map<anydata> variables = {"consent": consent};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <CreateStudentApplicantConsentResponse> check performDataBinding(graphqlResponse, CreateStudentApplicantConsentResponse);
    }

    remote isolated function createProspect(Prospect prospect) returns CreateProspectResponse|graphql:ClientError {
        string query = string `mutation createProspect($prospect:Prospect!) {add_prospect(prospect:$prospect) {name phone email receive_information_consent agree_terms_consent created street_address date_of_birth done_ol ol_year distance_to_school}}`;
        map<anydata> variables = {"prospect": prospect};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <CreateProspectResponse> check performDataBinding(graphqlResponse, CreateProspectResponse);
    }

    remote isolated function createStudentApplication(Application application) returns CreateStudentApplicationResponse|graphql:ClientError {
        string query = string `mutation createStudentApplication($application:Application!) {add_application(application:$application) {statuses {status}}}`;
        map<anydata> variables = {"application": application};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <CreateStudentApplicationResponse> check performDataBinding(graphqlResponse, CreateStudentApplicationResponse);
    }

    remote isolated function getApplication(int person_id) returns GetApplicationResponse|graphql:ClientError {
        string query = string `query getApplication($person_id:Int!) {application(person_id:$person_id) {application_date statuses {status updated}}}`;
        map<anydata> variables = {"person_id": person_id};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <GetApplicationResponse> check performDataBinding(graphqlResponse, GetApplicationResponse);
    }

    remote isolated function createEvaluations(Evaluation[] evaluations) returns json|graphql:ClientError {
        string query = string `mutation createEvaluations($evaluations: [Evaluation!]!)
                                {
                                    add_evaluations(evaluations:$evaluations) 
                                        
                                }`;
        map<anydata> variables = {"evaluations": evaluations};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        log:printInfo("Response: " + graphqlResponse.toString());
        return graphqlResponse;
    }

    remote isolated function getStudentApplicant(string jwt_sub_id) returns GetStudentApplicantResponse|graphql:ClientError {
        string query = string `query getStudentApplicant($jwt_sub_id:String!) {student_applicant(jwt_sub_id:$jwt_sub_id) {id asgardeo_id full_name preferred_name email phone jwt_sub_id jwt_email}}`;
        map<anydata> variables = {"jwt_sub_id": jwt_sub_id};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables);
        return <GetStudentApplicantResponse> check performDataBinding(graphqlResponse, GetStudentApplicantResponse);
    }
}
