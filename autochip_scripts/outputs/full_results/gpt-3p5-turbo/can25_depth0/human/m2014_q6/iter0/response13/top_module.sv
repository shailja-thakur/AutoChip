module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare state signals
	reg [2:0] state;
	reg [2:0] next_state;

	// State Definitions
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	// State register
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @* begin
		case(state)
			A: begin
				if(w == 1)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if(w == 1)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if(w == 1)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if(w == 1)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if(w == 1)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if(w == 1)
					next_state = D;
				else
					next_state = C;
			end
		endcase
	end

	// Output generation
	always @* begin
		case(state)
			A: begin
				z = 0;
			end
			B, C, D, E: begin
				z = 1;
			end
			F: begin
				if(w == 1)
					z = 0;
				else
					z = 1;
			end
		endcase
	end

endmodule
