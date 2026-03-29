# Third-Party Notices

This file documents the current licensing status we were able to verify for the
`CCAux` integration in this repository.

This is a project compliance note, not legal advice.

## Summary

- The repository does not currently declare a single root license for all
  source files.
- Several source files in `CCAux/` and other C++ files contain CrossControl AB
  copyright notices and "All rights reserved" headers.
- The build links against a vendor library named `cc-aux2` from
  `/opt/crosscontrol/...`.
- CrossControl's official CCAux API documentation states that the license of
  the API and related sources changed to `LGPLv2.1` in version `2.20.0.0`.
- CrossControl's official CCAux API documentation also states that support for
  `510/710` was added in version `2.19.0.0`.

Because of that version split, you should verify the exact `cc-aux2` package
version that is redistributed with the application before claiming LGPL-based
rights for the shipped library or for any copied source files.

## Repository-Specific Findings

- `CMakeLists.txt` includes CrossControl headers from
  `/opt/crosscontrol/include`.
- `CMakeLists.txt` links the application against `cc-aux2`.
- Files under `CCAux/` contain notices such as:
  `Copyright (C) 2020 CrossControl AB` and `All rights reserved.`
- The repository history shows the `CCAux/` directory was added in a single
  import-style commit rather than developed incrementally in this repository.

These findings mean the safe interpretation is:

- Treat `CCAux/` and `cc-aux2` as third-party/vendor materials.
- Do not label the entire repository as LGPL unless provenance for all affected
  files is confirmed.
- If you only know that the shipped runtime library is LGPL, document the
  library separately instead of relicensing the repository.

## What LGPLv2.1 Usually Requires When Shipping the Library

If the exact `cc-aux2` build you distribute is covered by `LGPLv2.1`, the usual
practical obligations include:

- Give notice that the application uses an LGPL-covered library.
- Provide a copy of the LGPLv2.1 license.
- Preserve copyright and license notices for the library.
- If you distribute the library binaries, provide the corresponding source for
  that LGPL library, or another LGPL-compliant source offer/access path.
- If you modify the LGPL library itself, provide those modifications under
  LGPLv2.1 as well.
- Do not impose extra restrictions that would prevent recipients from exercising
  the LGPL rights granted for the library.
- Be extra careful with static linking, because LGPLv2.1 includes additional
  relinking requirements for a "work that uses the Library".

For many app distributions, the simplest pattern is:

- Ship the app.
- Ship the LGPL license text.
- Publish or bundle the exact source corresponding to the LGPL library binary
  you distribute.
- Keep a clear note that the library is third-party and not the same thing as
  the repository's own source license status.

## Recommended Project Practice

For this repository, the recommended documentation approach is:

- Do not add a root `LICENSE` file that claims the whole repository is LGPL.
- Keep the LGPL text as a third-party license copy in `licenses/LGPL-2.1.txt`.
- Keep this file as the project note describing how `cc-aux2` is handled.
- If you publish releases that include the `cc-aux2` binary, also publish the
  corresponding source or compliant source offer for that exact library build.
- If later you confirm that copied source files from the CrossControl SDK were
  also released under LGPLv2.1, document the exact upstream version and package
  they came from before changing any repository-wide licensing statements.

## Official References

- GNU LGPL v2.1 license text:
  https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
- GNU LGPL v2.1 plain-text copy:
  https://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt
- GNU GPL FAQ entry covering static vs dynamic linking for the LGPL:
  https://www.gnu.org/licenses/gpl-faq.html#LGPLStaticVsDynamic
- CrossControl CCAux API `2.20.0.0` documentation:
  https://crosscontrol.com/manual/CCAux%20API/2.20.0.0/index.html
- CrossControl CCAux API `2.19.0.0` documentation:
  https://crosscontrol.com/manual/CCAux%20API/2.19.0.0/index.html

## Notes On Interpretation

- The statement that the license changed to `LGPLv2.1` comes from CrossControl's
  official `2.20.0.0` API documentation.
- The statement that support for `510/710` was added in `2.19.0.0` comes from
  CrossControl's official `2.19.0.0` API documentation.
- The conclusion that the exact shipped version must be verified is an
  inference based on those two official version notes.
