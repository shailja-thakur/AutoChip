module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	reg [2:0] current_state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	always @(current_state or w) begin
		case (current_state)
			A: if (w) next_state <= A;
			   else next_state <= B;
			B: if (w) next_state <= D;
			   else next_state <= C;
			C: if (w) next_state <= D;
			   else next_state <= E;
			D: if (w) next_state <= A;
			   else next_state <= F;
			E: if (w) next_state <= D;
			   else next_state <= E;
			F: if (w) next_state <= D;
			   else next_state <= C;
			default: next_state <= A;
		endcase
	end

	assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;

endmodule
