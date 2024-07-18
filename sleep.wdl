task workflow_start {
    command {
        echo starting
    }
    runtime {
      docker: "ubuntu"
    }
    output {
        String out = read_string(stdout())
    }
}

task sleep_across_restart {
    String task_in
    command {
        echo hello
        sleep 120 
        echo world
    }
    runtime {
      docker: "ubuntu"
    }
    output {
        String out = read_string(stdout())
    }
}

task workflow_end {
    String task_in
    command {
        echo ending
    }
    runtime {
      docker: "ubuntu"
    }
    output {
        String out = read_string(stdout())
    }
}

workflow w {
  call workflow_start
  call sleep_across_restart { input: task_in = workflow_start.out }
  call workflow_end { input: task_in = sleep_across_restart.out }

  output {
    String start_out = workflow_start.out
    String sleep_out = sleep_across_restart.out
    String end_out = workflow_end.out
  }
}
