use std::fmt;

pub struct Change {
    body: String,
}

impl Change {
    pub fn new(body: &str) -> Change {
        Change {
            body: body.to_string(),
        }
    }
}

impl fmt::Display for Change {
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
        //let res = lines.join(" ");
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
