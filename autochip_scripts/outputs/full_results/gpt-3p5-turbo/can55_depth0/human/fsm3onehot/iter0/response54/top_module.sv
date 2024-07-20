module top_module (
   input in,
   input [3:0] state,
   output reg [3:0] next_state,
   output reg out
);

// State transition logic
always @(*)
   case (state)
      4'b0001: next_state = (in) ? 4'b0010 : 4'b0001; // A
      4'b0010: next_state = (in) ? 4'b0010 : 4'b0100; // B
      4'b0100: next_state = (in) ? 4'b0001 : 4'b1000; // C
      4'b1000: next_state = (in) ? 4'b0100 : 4'b0010; // D
      default: next_state = 4'bxxxx; // invalid state
   endcase

// Output logic
// Moore state machine outputs a constant value for each state
always @(*)
   case (state)
      4'b0001: out = 1'b0; // A
      4'b0010: out = 1'b0; // B
      4'b0100: out = 1'b0; // C
      4'b1000: out = 1'b1; // D
      default: out = 1'b0; // invalid state
   endcase

endmodule
