module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define state encoding
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define state register and next state signal
	reg [1:0] state_reg, next_state;
	
	// Define output register
	reg out_reg;
	
	// Synchronous state and output register assignment
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= A; // Reset state to A
		end else begin
			state_reg <= next_state; // Update state based on next_state signal
		end
		
		case (state_reg)
			A: begin
				if (in)
					next_state = B; // Next state based on input in=1
				else
					next_state = A; // Next state based on input in=0
					
				out_reg = 1'b0; // Output based on current state (always 0 for A)
			end
			B: begin
				if (in)
					next_state = B; // Next state based on input in=1
				else
					next_state = C; // Next state based on input in=0
					
				out_reg = 1'b0; // Output based on current state (always 0 for B)
			end
			C: begin
				if (in)
					next_state = D; // Next state based on input in=1
				else
					next_state = A; // Next state based on input in=0
					
				out_reg = 1'b0; // Output based on current state (always 0 for C)
			end
			D: begin
				if (in)
					next_state = B; // Next state based on input in=1
				else
					next_state = C; // Next state based on input in=0
					
				out_reg = 1'b1; // Output based on current state (always 1 for D)
			end
		endcase
	end
	
	// Assign output to output register
	assign out = out_reg;
endmodule
