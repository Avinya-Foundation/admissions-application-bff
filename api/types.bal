public type Address record {
    string street_address?;
    string? name_ta?;
    int? phone?;
    string? name_si?;
    int? id?;
    string? record_type?;
    int city_id?;
    string name_en?;
};

public type ApplicantConsent record {
    string? date_of_birth?;
    string? created?;
    int? avinya_type_id?;
    boolean? agree_terms_consent?;
    boolean? active?;
    boolean? done_ol?;
    int? application_id?;
    int? ol_year?;
    string? record_type?;
    boolean? information_correct_consent?;
    int? phone?;
    int? organization_id?;
    string? name?;
    int? id?;
    int? distance_to_school?;
    string? email?;
    int? person_id?;
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
    string? record_type?;
    string name_en?;
};

public type Person record {
    int? permanent_address_id?;
    string? notes?;
    string? date_of_birth?;
    string? sex?;
    int? avinya_type_id?;
    string? passport_no?;
    string? record_type?;
    int? mailing_address_id?;
    string? full_name?;
    string? nic_no?;
    string? id_no?;
    int? phone?;
    int? organization_id?;
    int? id?;
    string? asgardeo_id?;
    string? preferred_name?;
    string? email?;
};

public type Prospect record {
    int? phone?;
    string? created?;
    string? name?;
    boolean? agree_terms_consent?;
    boolean? active?;
    int? id?;
    boolean? receive_information_consent?;
    string? record_type?;
    string? email?;
};

public type AvinyaType record{|
    int id?;
    boolean? active?;
    string? global_type?;
    string? name?;
    string? foundation_type?;
    string? focus?;
    int? level?;
|};

public type EvaluationCriteria record {|
    int id?;
    string? prompt?;
    string? description?;
    string? expected_answer?;
    string? evalualtion_type?;
    string? difficulty?;
    int? rating_out_of?;
    EvaluationCriteriaAnswerOption[]? answer_options?;
|};

public type EvaluationCriteriaAnswerOption record {|
    int id?;
    int? evaluation_criteria_id?;
    string? answer?;
    boolean? expected_answer?;
|};

public type Vacancy record {|
    int id?;
    string? name?;
    string? description?;
    int? organization_id?;
    int? avinya_type_id?;
    int? evaluation_cycle_id?;
    int? head_count?;
    AvinyaType? avinya_type?;
    EvaluationCriteria[]? evaluation_criteria?;
|};

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

public type CreateStudentApplicantConsentResponse record {|
    map<json?> __extensions?;
    record {|
        string? name;
        string? date_of_birth;
        boolean? done_ol;
        int? ol_year;
        int? distance_to_school;
        int? phone;
        string? email;
        boolean? information_correct_consent;
        boolean? agree_terms_consent;
    |}? add_student_applicant_consent;
|};

public type GetOrganizationVacanciesResponse record {|
    map<json?> __extensions?;
    record {|record {|
            record {|
                string name_en;
            |} name;
            record {|
                string street_address;
            |}? address;
            record {|
                string? name;
                boolean active;
                string global_type;
                string? foundation_type;
                string? focus;
                int? level;
            |}? avinya_type;
            int? phone;
            record {|record {|
                    string name_en;
                |} name; record {|
                    string? name;
                    string? description;
                    int? head_count;
                    record {|
                        string? name;
                        boolean active;
                        string global_type;
                        string? foundation_type;
                        string? focus;
                        int? level;
                    |}? avinya_type;
                    record {|
                        string? prompt;
                        string? description;
                        string? difficulty;
                        string? evalualtion_type;
                        int? rating_out_of;
                        record {|
                            string? answer;
                        |}[]? answer_options;
                    |}[]? evaluation_criteria;
                |}[]? vacancies;|}[]? child_organizations;
            record {|record {|
                    string name_en;
                |} name;|}[]? parent_organizations;
            record {|
                string? name;
                string? description;
                int? head_count;
            |}[]? vacancies;
        |}[]? organizations;|}? organization_structure;
|};

public type CreateProspectResponse record {|
    map<json?> __extensions?;
    record {|
        string? name;
        int? phone;
        string? email;
        boolean? receive_information_consent;
        boolean? agree_terms_consent;
        string? created;
    |}? add_prospect;
|};