module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    
	parameter A = 0;
	parameter B = 1;
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A; // Set state to A on reset
		end else begin
			case (state)
				A: begin
					if (x == 1) begin
						state <= B; // Set state to B if x is 1
					end else begin
						state <= A; // Stay in state A
					end
				end
				B: begin
					state <= B; // Stay in state B
				end
			endcase
		end
	end
	
	assign z = (state == A && x == 1) || (state == B && x == 0) ? 1 : 0; // Set z to 1 if conditions are met, otherwise 0

endmodule
