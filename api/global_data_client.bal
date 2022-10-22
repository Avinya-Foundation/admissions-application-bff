import ballerina/http;
import ballerina/graphql;

public isolated client class GlobalDataClient {
    final graphql:Client graphqlClient;
    
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig = {}) returns graphql:ClientError? {
        graphql:Client clientEp = check new (serviceUrl, clientConfig);
        self.graphqlClient = clientEp;
        return;
    }

    remote isolated function createStudentApplicant(Person person) returns CreateStudentApplicantResponse|graphql:ClientError {
        string query = string `mutation createStudentApplicant($person:Person!) {add_student_applicant(person:$person) {asgardeo_id preferred_name full_name sex organization {name {name_en}} phone email permanent_address {street_address city {name {name_en}} phone} mailing_address {street_address city {name {name_en}} phone} notes date_of_birth avinya_type {name active global_type foundation_type focus level} passport_no nic_no id_no}}`;
        map<anydata> variables = {"person": person};
        
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables,
            headers = {
                "API-Key": global_data_api_key});
        return <CreateStudentApplicantResponse> check performDataBinding(graphqlResponse, CreateStudentApplicantResponse);
    }

    remote isolated function getOrganizationVacancies(string name) returns GetOrganizationVacanciesResponse|graphql:ClientError {
        string query = string `query getOrganizationVacancies($name:String!) {organization_structure(name:$name) {organizations {name {name_en} address {street_address} avinya_type {name active global_type foundation_type focus level} phone child_organizations {name {name_en} vacancies {name description head_count avinya_type {name active global_type foundation_type focus level} evaluation_criteria {prompt description difficulty evalualtion_type rating_out_of answer_options {answer}}}} parent_organizations {name {name_en}} vacancies {name description head_count}}}}`;
        map<anydata> variables = {"name": name};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables,
            headers = {
                "API-Key": global_data_api_key});
        return <GetOrganizationVacanciesResponse> check performDataBinding(graphqlResponse, GetOrganizationVacanciesResponse);
    }

    remote isolated function createStudentApplicantConsent(ApplicantConsent consent) returns CreateStudentApplicantConsentResponse|graphql:ClientError {
        string query = string `mutation createStudentApplicantConsent($consent:ApplicantConsent!) {add_student_applicant_consent(applicantConsent:$consent) {name date_of_birth done_ol ol_year distance_to_school phone email information_correct_consent agree_terms_consent}}`;
        map<anydata> variables = {"consent": consent};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables,
            headers = {
                "API-Key": global_data_api_key});
        return <CreateStudentApplicantConsentResponse> check performDataBinding(graphqlResponse, CreateStudentApplicantConsentResponse);
    }

    remote isolated function createProspect(Prospect prospect) returns CreateProspectResponse|graphql:ClientError {
        string query = string `mutation createProspect($prospect:Prospect!) {add_prospect(prospect:$prospect) {name phone email receive_information_consent agree_terms_consent created}}`;
        map<anydata> variables = {"prospect": prospect};
        json graphqlResponse = check self.graphqlClient->executeWithType(query, variables,
            headers = {
                "API-Key": global_data_api_key});
        return <CreateProspectResponse> check performDataBinding(graphqlResponse, CreateProspectResponse);
    }
}
