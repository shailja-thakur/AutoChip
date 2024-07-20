module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define the states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	reg [2:0] current_state;
	reg [2:0] next_state;

	always @(posedge clk, posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	always @(*) begin
		case (current_state)
			A:
				if (w)
					next_state = A;
				else
					next_state = B;
				
			B:
				if (w)
					next_state = D;
				else
					next_state = C;
				
			C:
				if (w)
					next_state = D;
				else
					next_state = E;
				
			D:
				if (w)
					next_state = A;
				else
					next_state = F;
				
			E:
				if (w)
					next_state = D;
				else
					next_state = E;
				
			F:
				if (w)
					next_state = D;
				else
					next_state = C;
				
			default:
				next_state = A;
		endcase
	end

	always @(posedge clk) begin
		case (current_state)
			A: z <= 1'b0;
			E: z <= 1'b1;
			default: z <= 1'b0;
		endcase
	end

endmodule
