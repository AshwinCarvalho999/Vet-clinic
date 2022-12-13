CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT NULL REFERENCES patients(id) INT,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE invoices (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    total DECIMAL NOT NULL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT NULL REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE invoice_items (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT NULL REFERENCES invoices(id),
    treatment_id INT NULL REFERENCES treatments(id)
);

CREATE TABLE medical_histories_treatments (
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id)
);


CREATE INDEX treatments_id ON treatments(id);
CREATE INDEX patients_name ON patients(name);
CREATE INDEX medical_histories_id ON medical_histories(id);
CREATE INDEX invoice_items_id ON invoice_items(id);
CREATE INDEX patients_id ON patients(id);
CREATE INDEX medical_histories_treatments_medical_history_id ON medical_histories_treatments(medical_history_id);
CREATE INDEX medical_histories_treatments_treatment_id ON medical_histories_treatments(treatment_id);
CREATE INDEX invoices_id ON invoices(id);