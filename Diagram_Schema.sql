CREATE DATABASE hospital;

CREATE TABLE medical_histories (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR,
    PRIMARY KEY(id)
);

CREATE TABLE patients (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR,
    date_of_birth DATE,
    PRIMARY KEY(id)
);

CREATE TABLE invoices (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    PRIMARY KEY(id)
);

CREATE TABLE treatments (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    type VARCHAR,
    name VARCHAR,
    PRIMARY KEY(id)
);

CREATE TABLE treatments_history (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    medical_history_id INT,
    treatment_id INT,
    PRIMARY KEY(id)
);

-- Foreign keys
ALTER TABLE medical_histories
ADD CONSTRAINT fk_medical_histories
FOREIGN KEY (patient_id)
REFERENCES patients (id);
ALTER TABLE invoices
ADD CONSTRAINT fk_invoices
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories (id);
ALTER TABLE invoice_items
ADD CONSTRAINT fk_invoices_items
FOREIGN KEY (invoice_id)
REFERENCES invoices (id);
ALTER TABLE invoice_items
ADD CONSTRAINT fk_invoice_treatments
FOREIGN KEY (treatment_id)
REFERENCES treatments (id);
ALTER TABLE treatments_history
ADD CONSTRAINT fk_treatments_history
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories (id);
ALTER TABLE treatments_history
ADD CONSTRAINT fk_treatments
FOREIGN KEY (treatment_id)
REFERENCES treatments (id);

-- Indexes for Foreign Keys
CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id, treatment_id);
CREATE INDEX ON treatments_history (medical_history_id, treatment_id);