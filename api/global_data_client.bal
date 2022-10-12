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
                "API-Key": "eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI3ODNmMmNiMi01ZWQyLTQ4OTMtYjA1NC0yMTc5NGNlYzhmOTBAY2FyYm9uLnN1cGVyIiwiaXNzIjoiaHR0cHM6XC9cL3N0cy5jaG9yZW8uZGV2OjQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOm51bGwsIm5hbWUiOiJHbG9iYWwgRGF0YSBHcmFwaFFMIEFQSSIsImNvbnRleHQiOiJcLzNhOTA3MTM3LTUyYTMtNDE5Ni05ZTBkLTIyZDA1NGVhNTc4OVwvbWhid1wvZ2xvYmFsLWRhdGEtZ3JhcGhxbC1hcGlcLzEuMC4wIiwicHVibGlzaGVyIjoiY2hvcmVvX3Byb2RfYXBpbV9hZG1pbiIsInZlcnNpb24iOiIxLjAuMCIsInN1YnNjcmlwdGlvblRpZXIiOm51bGx9XSwiZXhwIjoxNjY1NjEyNjY2LCJ0b2tlbl90eXBlIjoiSW50ZXJuYWxLZXkiLCJpYXQiOjE2NjU1NTI2NjYsImp0aSI6IjYxYzMzNzdjLTRmYWYtNDRkZC1hZDNjLTc5MTE0ODc1NTc2ZiJ9.V-HSp6KfRoIFvPho5mcBKe_EyYMGmo1SqsQ9P6ILx9B2GYe1Nhqz52zcOMPNLnVpPgF8z_OFsMVfWSlT-T97VgZh2LiC90c9firr7MRjKCm6OJw7-YlTn4gnnsAwfKg3xTNqYE8Wc1LVZS45GSH0oN828souWrdXmK-6zzPP0WiFRVQXivBOdS_DL3h9J9FQ1To2qEFTCF0fXeDkKra2gnl1XKr-eK5xB-g_izAhrtPteVNsTe27HomwB4mUJ9IcSmm-ECjbri8IuQ57zLdhqEUho-jeHFykLzKI3Yo1duzkFBMnTDm94HSvRCYg7_Rv8H48JGNcAz6ligfVUtwK6KqHGwkrWzDIAGjZFhSgX10qGthFpG50DG0Y3CQrI9AsmiuPbD3Uyv3iov1MXn-U84wKvo9k70g77nMj8qyi-ormUQAxUx-A-Docyn6LV-PSx8J0eovf1a0fOcjMhWNoRQmAfaS9uU9lbE_jyNlSHEKl4xqlJRuk3CfKRRvu7gVepC9mC4LzpCUCfHdepY3s3j8PM_zG0LjnYKlH94Dtg0kchRP6GHP4wUZQYF-K9M86NoWqM13grGg753tbRDd7wsp60i6L7nwbUptuZxFugEFunU_OdC1uOZEOkvt6Yt2NiOmFKOVMMlNbIBwxVrhIhqQfrMhUnJZA6e8Aoc5fKhU"});
        return <CreateStudentApplicantResponse> check performDataBinding(graphqlResponse, CreateStudentApplicantResponse);
    }
}
