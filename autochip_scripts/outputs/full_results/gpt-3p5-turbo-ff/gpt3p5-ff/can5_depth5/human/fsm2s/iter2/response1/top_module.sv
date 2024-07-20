module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);
  
  // Define the states
  parameter OFF = 0;
  parameter ON = 1;
  
  // Define the state register and next state variable
  reg [1:0] state, next_state;
  
  // Synchronous reset to state OFF
  always @(posedge clk) begin
    if (reset)
      state <= OFF;
    else
      state <= next_state;
  end
  
  // State transition logic and next state assignment
  always @(*) begin
    next_state = state;
    case(state)
      OFF: begin
        if (j)
          next_state = ON;
        else
          next_state = OFF;
      end
      ON: begin
        if (k)
          next_state = OFF;
        else
          next_state = ON;
      end
      default: next_state = OFF;
    endcase
  end
  
  // Output assignment
  always @(state) begin
    case(state)
      OFF: out = 0;
      ON: out = 1;
      default: out = 0;
    endcase
  end
  
endmodule
