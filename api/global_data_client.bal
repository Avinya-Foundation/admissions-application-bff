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
                "API-Key": "eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI3ODNmMmNiMi01ZWQyLTQ4OTMtYjA1NC0yMTc5NGNlYzhmOTBAY2FyYm9uLnN1cGVyIiwiaXNzIjoiaHR0cHM6XC9cL3N0cy5jaG9yZW8uZGV2OjQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOm51bGwsIm5hbWUiOiJHbG9iYWwgRGF0YSBHcmFwaFFMIEFQSSIsImNvbnRleHQiOiJcLzNhOTA3MTM3LTUyYTMtNDE5Ni05ZTBkLTIyZDA1NGVhNTc4OVwvbWhid1wvZ2xvYmFsLWRhdGEtZ3JhcGhxbC1hcGlcLzEuMC4wIiwicHVibGlzaGVyIjoiY2hvcmVvX3Byb2RfYXBpbV9hZG1pbiIsInZlcnNpb24iOiIxLjAuMCIsInN1YnNjcmlwdGlvblRpZXIiOm51bGx9XSwiZXhwIjoxNjY1NDU0MDM2LCJ0b2tlbl90eXBlIjoiSW50ZXJuYWxLZXkiLCJpYXQiOjE2NjUzOTQwMzYsImp0aSI6IjIyMGZiN2U2LTNiMjMtNDRmNS04NzU4LTJmZmJkNjBlZjM4MCJ9.jKZT6NgQFHbjIswlHEgUJvEV4u1x8Oqac1dSDQRvuElaeOgHK-SUcv2wF7GHgf7YRV75BGOr_zoS7Thcwbd0ZgqCCbQ99Z2jsM8hnaDqBtZeyAQLuZL1hMjJ7WwDjjt1LYpU_Wtu_euEq0UsNNrLZsToQuWr2ziToJCFy_hbV9E4VfRHtRucmYhCXVWnmBuIQcrJh2fxIEI5kkYZhFA6367evqKH51q-r7Zzgethup7K4l9H-HkEhoIDVhZ4M2VbhnQirC73-TK2c2nmfbocFVSKX14ki8VCD44tUcUOU7EC9NNQ3jm16qUH4ndDD_MyG-A6yOlD1apts8087OvUMvjR9Tcn6IVLHICQDW0Uqcy7MYbVtW_v1mDHltG7G6cwArjm1kPZxu-uYcHekgsfaAgayCMZcou9gXXDhiyCkHnUf1cCj4dWUuTFpaXVPsXe5dZf_HFLSxM9g6igjIvQCA0Xvd5VG9qPDwoWkh2rgomIaV5wrgGq7Uzpl473dzzgWHKiEo9cw64GvkO2pb4cl8sNebCm6ovjAaKEYlP7vNbM5zMBERO8koXlMeazJCXsFdPiDthohXZj1UUf0lFY-gti_2FUU_nbrEm6TOEheNpHMPNDwWuDNtdbODGGg764RbHLl-uoCm0ZXJkiwzzMRpnwsO5mTMH83Eb73c89Zts"});
        return <CreateStudentApplicantResponse> check performDataBinding(graphqlResponse, CreateStudentApplicantResponse);
    }
}
