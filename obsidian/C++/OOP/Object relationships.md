## Composition

In real-life, complex objects are often built from smaller, simpler objects. For example, a car is built using a metal frame, an engine, some tires, a transmission, a steering wheel, and a large number of other parts. A personal computer is built from a CPU, a motherboard, some memory, etc… Even you are built from smaller parts: you have a head, a body, some legs, arms, and so on. This process of building complex objects from simpler ones is called **object composition**.

Broadly speaking, object composition models a “**has-a**” relationship between two objects. A car “has-a” transmission. Your computer “has-a” CPU. You “have-a” heart. The complex object is sometimes called the whole, or the parent. The simpler object is often called the part, child, or component.

To qualify as a **composition**, an object and a part must have the following relationship:

- The part (member) is part of the object (class)
- The part (member) can only belong to one object (class) at a time
- The part (member) has its existence managed by the object (class)
- The part (member) does not know about the existence of the object (class)

Composition represents a strong "has-a" relationship where the part cannot exist without the whole. If the whole is destroyed, the part is also destroyed.

### Example

Consider a `Human` class and a `Heart` class. A `Human` object is composed of a `Heart` object. A heart cannot exist without a human (in this context), so this is a composition relationship.

```c++
class Heart {
    // Heart class code
};

class Human {
private:
    Heart heart; // Heart is part of Human
public:
    // Human class code
};
```
## Aggregation

Like a composition, an aggregation is still a part-whole relationship, where the parts are contained within the whole, and it is a unidirectional relationship. However, unlike a composition, parts can belong to more than one object at a time, and the whole object is not responsible for the existence and lifespan of the parts. When an aggregation is created, the aggregation is not responsible for creating the parts. When an aggregation is destroyed, the aggregation is not responsible for destroying the parts.

To qualify as an **aggregation**, a whole object and its parts must have the following relationship:

- The part (member) is part of the object (class)
- The part (member) can (if desired) belong to more than one object (class) at a time
- The part (member) does _not_ have its existence managed by the object (class)
- The part (member) does not know about the existence of the object (class)

Aggregation represents a weaker "has-a" relationship where the part can exist independently of the whole. If the whole is destroyed, the part can still exist.

### Example

Consider a `Library` class and a `Book` class. A `Library` object can have multiple `Book` objects. However, if the `Library` object is destroyed, the `Book` objects can still exist because a book can exist independently of a library.

```c++
class Book {
    // Book class code
};

class Library {
private:
    Book* books; // Library has Books
public:
    // Library class code
};
```

## Association

Unlike a composition or aggregation, where the part is a part of the whole object, in an association, the associated object is otherwise unrelated to the object. Just like an aggregation, the associated object can belong to multiple objects simultaneously, and isn’t managed by those objects. However, unlike an aggregation, where the relationship is always unidirectional, in an association, the relationship may be unidirectional or bidirectional (where the two objects are aware of each other).

To qualify as an **association**, an object and another object must have the following relationship:

- The associated object (member) is otherwise unrelated to the object (class)
- The associated object (member) can belong to more than one object (class) at a time
- The associated object (member) does _not_ have its existence managed by the object (class)
- The associated object (member) may or may not know about the existence of the object (class)

The relationship between doctors and patients is a great example of an association. The doctor clearly has a relationship with his patients, but conceptually it’s not a part/whole (object composition) relationship. A doctor can see many patients in a day, and a patient can see many doctors (perhaps they want a second opinion, or they are visiting different types of doctors). Neither of the object’s lifespans are tied to the other.

We can say that association models as “**uses-a**” relationship. The doctor “uses” the patient (to earn income). The patient uses the doctor (for whatever health purposes they need).

```c++
class Patient;

class Doctor {
private:
    std::vector<Patient*> patients;
public:
    void addPatient(Patient* patient) {
        patients.push_back(patient);
    }
    // Other Doctor class code
};

class Patient {
private:
    std::vector<Doctor*> doctors;
public:
    void addDoctor(Doctor* doctor) {
        doctors.push_back(doctor);
        doctor->addPatient(this);
    }
    // Other Patient class code
};
```

## Dependencies

A **dependency** occurs when one object invokes another object’s functionality in order to accomplish some specific task. This is a weaker relationship than an association, but still, any change to object being depended upon may break functionality in the (dependent) caller. A dependency is always a unidirectional relationship.

```c++
class Document {
public:
    void printContent() {
        // code to return the content of the document
    }
};

class Printer {
public:
    void printDocument(Document document) {
        document.printContent();
        // code to print the document
    }
};

int main() {
    Document document;
    Printer printer;
    printer.printDocument(document);
    return 0;
}
```

This design creates a dependency from the `Printer` class to the `Document` class because the `Printer` class uses the `Document` class to perform the printing. However, the `Document` class does not depend on the `Printer` class, so the dependency is unidirectional.