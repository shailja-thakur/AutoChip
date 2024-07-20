module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	parameter B = 0;
	parameter A = 1;
	
	// Register for current state
	reg [1:0] current_state;
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= B;
		else begin
			case (current_state)
				B: begin
					if (in)
						current_state <= B;
					else
						current_state <= A;
				end
				
				A: begin
					if (in)
						current_state <= A;
					else
						current_state <= B;
				end
			endcase
		end
	end
	
	// Output logic
	assign out = (current_state == B) ? 1'b1 : 1'b0;
endmodule
