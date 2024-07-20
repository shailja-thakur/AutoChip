module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  
  reg [1:0] state;
  wire [1:0] next_state;
  
  // State transition logic
  always @ (posedge clk or posedge areset)
    if (areset)
      state <= 2'b01;  // Set initial state to B
    else
      state <= next_state;

  // Output logic
  always @*
    case (state)
      2'b00: out = 1'b0;
      2'b01: out = 1'b0;
      2'b10: out = 1'b1;
      2'b11: out = 1'b1;
    endcase

  // Next state logic
  always @*
    case ({state, in})
      2'b00: next_state = 2'b01;
      2'b01: next_state = 2'b10;
      2'b10: next_state = 2'b00;
      2'b11: next_state = 2'b11;
      default: next_state = 2'b00;
    endcase
endmodule
