module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State Definitions
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Registers
	reg [1:0] state;
	reg [1:0] next_state;
	reg z_out;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			z_out <= 0;
		end
		else begin
			state <= next_state;
			z_out <= (state == E) ? 1 : 0;
		end
	end
	
	always @(state or w) begin
		case (state)
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
	
	assign z = z_out;
endmodule
