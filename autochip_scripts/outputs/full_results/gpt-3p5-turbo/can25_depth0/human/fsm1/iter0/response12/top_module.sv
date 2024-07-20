module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	parameter B = 0;
	parameter A = 1;

	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else begin
			case(state)
				B: begin
					if (in == 0)
						state <= A;
					else if (in == 1)
						state <= B;
				end
				
				A: begin
					if (in == 0)
						state <= B;
					else if (in == 1)
						state <= A;
				end
			endcase
		end
	end
	
	// Outputs
	assign out = state;
endmodule
