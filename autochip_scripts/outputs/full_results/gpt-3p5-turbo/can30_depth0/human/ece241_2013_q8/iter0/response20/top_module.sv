module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	// Define states
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;

	reg [1:0] state;
	
	// Negative edge triggered reset
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			case (state)
				S0: if (x == 1'b1)
						state <= S1;
					 else
						state <= S0;
						
				S1: if (x == 1'b0)
						state <= S2;
					 else
						state <= S0;
						
				S2: if (x == 1'b1)
						begin
							state <= S1;
							z <= 1'b1;  // Output asserted when "101" sequence is detected
						end
					 else
						state <= S0;
			endcase
	end
	
endmodule
