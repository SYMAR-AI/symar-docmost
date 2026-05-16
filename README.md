<div align="center">
    <h1><b>SYMAR Docmost</b></h1>
    <p>
        Collaborative documentation and knowledge management for the SYMAR ecosystem.
        <br />
        Integrated with <strong>SYMAR Knowledge Hub</strong> to organize, manage, and share structured knowledge.
    </p>
</div>

<br />

## Overview

`SYMAR-AI/symar-docmost` is the documentation and collaborative wiki layer for the SYMAR platform.  
It is based on Docmost and is used to create, edit, organize, and maintain internal or shared knowledge in a structured workspace.

Within the SYMAR ecosystem, this repository serves as the **documentation interface and content collaboration system**, while [`SYMAR-AI/knowledge-hub`](https://github.com/SYMAR-AI/knowledge-hub) acts as the broader **knowledge repository and integration layer** for storing, connecting, and operationalizing information.

In short:

- **symar-docmost** = where knowledge is written, edited, documented, and collaboratively maintained
- **knowledge-hub** = where knowledge is aggregated, connected, and made usable across the wider SYMAR system

## How it works

SYMAR Docmost provides a workspace where teams can:

- Create and edit documentation pages
- Organize knowledge into spaces or categories
- Collaborate in real time
- Track revisions and page history
- Manage user access and permissions
- Attach files and embed external tools
- Make documentation searchable and easy to navigate

This makes it useful for:

- Product documentation
- Internal operational guides
- Team knowledge bases
- Research notes
- Project documentation
- Shared institutional knowledge

## Connection to SYMAR Knowledge Hub

`SYMAR-AI/knowledge-hub` and `SYMAR-AI/symar-docmost` are complementary parts of the same knowledge ecosystem.

### Role of `symar-docmost`
This repository focuses on the **authoring and collaboration experience**. It gives users a clean interface for writing and managing knowledge content.

### Role of `knowledge-hub`
`knowledge-hub` provides the **broader knowledge structure**, which may include centralized organization, indexing, workflows, integrations, and downstream usage of documented content.

### How they connect
The relationship between the two repositories can be understood as:

1. Knowledge is created and maintained inside **SYMAR Docmost**
2. That knowledge becomes part of the wider **SYMAR Knowledge Hub**
3. The Knowledge Hub can then organize, surface, connect, or distribute that information across other SYMAR tools and processes

This means Docmost is the **collaborative documentation front end**, while Knowledge Hub is the **larger system that gives that documentation context, accessibility, and operational value**.

## Key Features

- Real-time collaboration
- Structured documentation spaces
- Searchable knowledge pages
- Permissions and access control
- Comments and collaboration workflows
- File attachments and rich embeds
- Revision history
- Multilingual support
- Flexible knowledge organization for teams and projects

## Why this repository exists

The purpose of `symar-docmost` is to give the SYMAR ecosystem a dedicated documentation environment that is easy to use, collaborative, and scalable.

By connecting it with `knowledge-hub`, SYMAR can ensure that documentation is not isolated, but instead becomes part of a broader, connected knowledge infrastructure.

## License

This repository is based on Docmost.

Docmost core is licensed under the open-source AGPL 3.0 license.  
Enterprise features are available under an enterprise license (Enterprise Edition).  

All files in the following directories are licensed under the Docmost Enterprise license defined in `packages/ee/License`:

- `apps/server/src/ee`
- `apps/client/src/ee`
- `packages/ee`

## Acknowledgments

Built on top of the open-source Docmost project.

Special thanks to the original Docmost contributors and ecosystem.
