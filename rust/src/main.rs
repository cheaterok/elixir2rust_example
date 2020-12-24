use std::fs::File;
use std::io::{BufRead, BufReader, Write, LineWriter};
use std::os::unix::io::FromRawFd;

fn main() -> Result<(), std::io::Error> {
    let node_name = std::env::args().nth(1).unwrap();

    let in_fd = unsafe { File::from_raw_fd(3) };
    let out_fd = unsafe { File::from_raw_fd(4) };

    let reader = BufReader::new(in_fd);
    let mut writer = LineWriter::new(out_fd);

    let mut stdout = std::io::stdout();

    writeln!(stdout, "Receive loop on node: {}", node_name)?;
    for line in reader.lines() {
        let line = line?;
        writeln!(stdout, "Got {:?}", line)?;
        let reversed = line.chars().rev().collect::<String>();
        writeln!(writer, "{}", reversed)?;
    }

    Ok(())
}
