//
// Author:: Jonathan Hartman (<j@p4nt5.com>)
// License:: Apache License, Version 2.0
//
// Copyright (C) 2015, Jonathan Hartman
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

use std::fmt;

/// A struct to represent a single changelog item.
pub struct Change {
    body: String,
}

impl Change {
    /// Constructs a new `Change`.
    ///
    /// # Examples
    ///
    /// ```
    /// use changelog::change::Change;
    /// let c = Change::new("The body of a change");
    /// ```
    pub fn new(body: &str) -> Change {
        Change {
            body: body.to_string(),
        }
    }
}

impl fmt::Display for Change {
    /// Formats a change into a bullet point for a changelog file with a max
    /// line length of 79 characters.
    ///
    /// # Examples
    ///
    /// ```
    /// use changelog::change::Change;
    /// let c = Change::new("The body of a change");
    /// println!("{}", c);
    /// ```
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let mut lines: Vec<String> = Vec::new();
        let mut next_line = String::new();
        next_line.push('-');
        //let mut lines = vec![String::new()];
        for word in self.body.split_whitespace() {
            if next_line.len() + 1 + word.len() > 79 {
                lines.push(next_line);
                next_line = String::new();
                next_line.push(' ');
            }
            next_line.push(' ');
            next_line.push_str(word);
        }
        lines.push(next_line);
        write!(f, "{}", lines.join("\n"))
    }
}

#[test]
fn a_short_line() {
    let c = Change::new("A short line");
    assert_eq!(c.to_string(), "- A short line");
}

#[test]
fn a_long_line() {
    let c = Change::new("This line is long, whatever are we going to do when it gets too long \
                         to fit on one line?");
    assert_eq!(c.to_string(), "- This line is long, whatever are we going to do when it gets \
                               too long to fit\n  on one line?");
}
