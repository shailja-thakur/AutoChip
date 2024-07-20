module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	parameter E = 2'b100;
	parameter F = 2'b101;
	
	reg [1:0] curr_state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end

	always @(curr_state or w) begin
		case (curr_state)
			A: begin
				if (w)
					next_state <= B;
				else
					next_state <= A;
			end
			B: begin
				if (w)
					next_state <= C;
				else
					next_state <= D;
			end
			C: begin
				if (w)
					next_state <= E;
				else
					next_state <= D;
			end
			D: begin
				if (w)
					next_state <= F;
				else
					next_state <= A;
			end
			E: begin
				if (z)
					next_state <= E;
				else
					next_state <= D;
			end
			F: begin
				if (z)
					next_state <= C;
				else
					next_state <= D;
			end
			default: next_state <= A;
		endcase
	end

	always @(curr_state) begin
		case (curr_state)
			A: z = 1'b0;
			E: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
