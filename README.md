# SimpleText to HTML Parser (Grammar and Syntax Analysis)

## About

**SimpleText to HTML Parser** is an OCaml-based grammar and syntax analysis project developed as a third-year Bachelor's (L3) project at Université Paris Cité. Built using modern OCaml tooling, the project implements a complete compilation pipeline—from lexical analysis and parsing to Abstract Syntax Tree (AST) generation and HTML translation—for a custom lightweight markup language.

The project demonstrates advanced compilation concepts, leveraging **Ocamllex** for tokenization and **Menhir** for LR(1) parser generation, orchestrated via the **Dune** build system.

*Note: As this was originally an academic project, the codebase and documentation comments may contain some French.*

## Tech Stack

- **Language:** OCaml
- **Parser Generator:** Menhir
- **Lexer Generator:** Ocamllex
- **Build System:** Dune
- **Environment Management:** OPAM

## Key Features

- **Custom Markup Parsing:** Converts lightweight document syntax into clean, semantic HTML output (`out.html`).
- **Rich Text Formatting:** Full support for bold (`**`), italic (`*`), combined bold-italic, custom text colors (`\color`), and hyperlinks.
- **Document Structure:** Supports Level 1 (`#`) and Level 2 (`##`) titles, paragraphs, and complex nested lists (`\item`).
- **Macro System:** Custom macro definition and expansion support via `\define` directives.
- **Robust Pipeline:** Strict separation of concerns between lexical analysis (`lexer.mll`), grammar rules (`parser.mly`), Abstract Syntax Tree (`ast.ml`), and execution logic (`main.ml`).

## Project Structure

```text
📁 simpletext-to-html
│
├── 📁 projet
│   ├── 📁 bin/
│   │   ├── ast.ml                # Abstract Syntax Tree definition and HTML generation logic
│   │   ├── dune                  # Executable and toolchain configuration (Ocamllex/Menhir)
│   │   ├── lexer.mll             # Lexical analyzer definitions (Ocamllex)
│   │   ├── main.ml               # Main entry point and file output handler
│   │   └── parser.mly            # Grammar rules and parser definitions (Menhir)
│   │
│   ├── 📁 exemples/              # Sample source files demonstrating syntax features
│   ├── 📁 lib/                   # Library target configuration
│   └── 📁 test/                  # Unit tests and test suites
│
└── 📄 README.md                  # Project documentation
```

## Getting Started

### Prerequisites

- OCaml
- OPAM (OCaml Package Manager)
- Dune build system
- Menhir & Ocamllex

### Installation & Execution

1. **Clone the repository:**
```bash
git clone https://github.com/SuyuKuka/simpletext-to-html.git
cd simpletext-to-html/projet
```

2. **Initialize the OPAM environment:**
```bash
eval $(opam env)
```

3. **Build the project:**
```bash
dune build
```

4. **Run the parser on an example file:**
```bash
./_build/default/bin/main.exe < exemples/exemple1.txt
```

5. **Cleaning**
```bash
dune clean
```

*The generated HTML output will be saved to `out.html`.*

## Team

This project was developed collaboratively as a 2-person team:

- **CHEN Michel** - Ocaml Development & Parsing Architecture 
  [![GitHub](https://img.shields.io/badge/GitHub-Profile-181717?logo=github)](https://github.com/SuyuKuka)
  [![LinkedIn](https://img.shields.io/badge/LinkedIn-Profile-0A66C2?logo=linkedin)](https://linkedin.com/in/chen-michel)

- **CHIV Henri** - Ocaml Development & Parsing Architecture
  [![GitHub](https://img.shields.io/badge/GitHub-Profile-181717?logo=github)](https://github.com/H-flamme)

## License

This repository contains academic coursework.

- The initial basecode are the intellectual property of the teaching staff. They are included here strictly for context and evaluation purposes.

This project is shared for portfolio and reference purposes only.