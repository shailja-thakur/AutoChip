module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state; // Present State
reg [2:0] next_state; // Next State

// Define the state assignments
parameter S0 = 3'b000; // 000
parameter S1 = 3'b001; // 001
parameter S2 = 3'b010; // 010
parameter S3 = 3'b011; // 011
parameter S4 = 3'b100; // 100

// Define the next state assignments for x = 0
always @(*)
case(state)
  S0: next_state = x ? S1 : S0;
  S1: next_state = x ? S4 : S1;
  S2: next_state = x ? S1 : S2;
  S3: next_state = x ? S2 : S1;
  S4: next_state = x ? S4 : S3;
endcase

// Define the output assignments
always @(posedge clk or posedge reset)
if (reset)
 begin
   state <= S0;
   z <= 1'b0;
 end
else
 begin
   state <= next_state;
   z <= (state == S3) ? 1'b1 : 1'b0;
 end
endmodule
