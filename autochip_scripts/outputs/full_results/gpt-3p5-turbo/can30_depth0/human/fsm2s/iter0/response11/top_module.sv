module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

  // Define states
  parameter OFF = 0;
  parameter ON = 1;

  // Create state and next_state variables
  reg [1:0] state;
  reg [1:0] next_state;

  // Define output reg
  always @(state) begin
    case(state)
      OFF: out = 0;
      ON: out = 1;
    endcase
  end
  
  // Define state transition and output assignment
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= OFF;
    end 
    else begin
      state <= next_state;
    end
  end
  
  // Define next_state logic
  always @(state, j, k) begin
    case(state)
      OFF: if (j) next_state = ON; else next_state = OFF;
      ON: if (k) next_state = OFF; else next_state = ON;
    endcase
  end

endmodule
