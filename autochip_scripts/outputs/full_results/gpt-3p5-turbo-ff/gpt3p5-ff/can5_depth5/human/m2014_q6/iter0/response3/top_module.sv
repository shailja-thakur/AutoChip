module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare states
	parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
	reg [2:0] state, next_state;
	
	// Declare outputs
	reg z_reg;
	
	// Define state transition logic
	always @(posedge clk) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Define next state and output logic
	always @* begin
		case(state)
			A: begin
				if (w)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if (w)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
		endcase
	end
	
	// Define output logic
	always @(posedge clk) begin
		case(state)
			E: z_reg <= 1;
			default: z_reg <= 0;
		endcase
	end
	
	// Assign output
	assign z = z_reg;
	
endmodule
