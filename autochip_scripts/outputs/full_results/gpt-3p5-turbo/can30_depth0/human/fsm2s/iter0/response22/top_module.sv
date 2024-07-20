module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  // Define the states for the state machine
  typedef enum logic [1:0] {
    OFF,
    ON
  } state_type;

  // Define the state register and next state variables
  reg state_type state, next_state;

  // Define the output register and next output variable
  reg out, next_out;

  // State transition and output logic
  always @(posedge clk) begin
    // Synchronous reset
    if (reset) begin
      state <= OFF;
      out <= 0;
    end
    else begin
      state <= next_state;
      out <= next_out;
    end
  end

  always @(*) begin
    // Combinational logic for next state and next output
    case (state)
      OFF: begin
        if (j)
          next_state = ON;
        else
          next_state = OFF;
        next_out = 0;
      end
      ON: begin
        if (k)
          next_state = OFF;
        else
          next_state = ON;
        next_out = 1;
      end
      default: begin
        next_state = OFF;
        next_out = 0;
      end
    endcase
  end

  // Output assignment
  assign out = next_out;

endmodule
