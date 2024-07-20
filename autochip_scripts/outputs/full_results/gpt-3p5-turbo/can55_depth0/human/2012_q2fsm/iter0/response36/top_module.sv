module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// State and output registers
	reg [1:0] current_state, next_state;
	reg z_reg;
	
	// State transition and output logic
	always @ (current_state, w) begin
		case (current_state)
			A: begin
				if (w)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
			
			C: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			
			D: begin
				if (w)
					next_state = F;
				else
					next_state = A;
			end
			
			E: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			
			F: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end
	
	always @ (posedge clk, posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always @ (current_state) begin
		case (current_state)
			E: z_reg = 1;
			default: z_reg = 0;
		endcase
	end
	
	assign z = z_reg;
	
endmodule
