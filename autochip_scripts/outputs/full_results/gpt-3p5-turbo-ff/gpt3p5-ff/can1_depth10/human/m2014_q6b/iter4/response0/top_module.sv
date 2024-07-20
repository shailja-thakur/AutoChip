module top_module(
	input [3:1] y,
	input w,
	input wire clk,
	output reg Y2);

	// define the states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	reg [2:0] next_state;
	
	// define the next state logic for y[2]
	always @* begin
		case (y[3:1])
			A: next_state = (w == 0) ? B : A;
			B: next_state = (w == 0) ? C : D;
			C: next_state = (w == 0) ? E : D;
			D: next_state = (w == 0) ? F : A;
			E: next_state = (w == 0) ? E : D;
			F: next_state = (w == 0) ? C : D;
			default: next_state = A;
		endcase
	end
	
	always @(posedge clk) begin
		Y2 <= next_state[2];
	end
endmodule
