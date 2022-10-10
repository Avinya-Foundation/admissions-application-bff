public type Address record {
    string street_address?;
    string? name_ta?;
    int? phone?;
    string? name_si?;
    int? id?;
    string record_type?;
    int city_id?;
    string name_en?;
};

public type Organization record {
    int[]? parent_organizations?;
    string? name_ta?;
    int[]? child_organizations?;
    int? phone?;
    int? address_id?;
    string? name_si?;
    int? avinya_type?;
    int? id?;
    string record_type?;
    string name_en?;
};

public type Person record {
    string record_type?;
    string? preferred_name?;
    string? full_name?;
    string? notes?;
    string? date_of_birth?;
    string? sex?;
    int? avinya_type_id?;
    string? passport_no?;
    int? permanent_address_id?;
    int? mailing_address_id?;
    string? nic_no?;
    string? id_no?;
    int? phone?;
    int? organization_id?;
    int? id?;
    string? asgardeo_id?;
    string? email?;
};

public type CreateStudentApplicantResponse record {|
    map<json?> __extensions?;
    record {|
        string? asgardeo_id;
        string? preferred_name;
        string? full_name;
        string? sex;
        record {|record {|
                string name_en;
            |} name;|}? organization;
        int? phone;
        string? email;
        record {|
            string street_address;
            record {|record {|
                    string name_en;
                |} name;|} city;
            int? phone;
        |}? permanent_address;
        record {|
            string street_address;
            record {|record {|
                    string name_en;
                |} name;|} city;
            int? phone;
        |}? mailing_address;
        string? notes;
        string? date_of_birth;
        record {|
            string? name;
            boolean active;
            string global_type;
            string? foundation_type;
            string? focus;
            int? level;
        |}? avinya_type;
        string? passport_no;
        string? nic_no;
        string? id_no;
    |}? add_student_applicant;
|};
