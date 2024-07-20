module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	// Declare state variables
	reg [3:0] state;
	
	// Define constants for state encoding
	parameter S0 = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;
	
	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (data)
						state <= S1;
				end
				S1: begin
					if (data)
						state <= S2;
					else
						state <= S0;
				end
				S2: begin
					if (data)
						state <= S3;
					else
						state <= S0;
				end
				S3: begin
					if (data)
						state <= S4;
					else
						state <= S0;
				end
				S4: begin
					if (data)
						start_shifting <= 1;
					state <= S4;
				end
			endcase
		end
	end
	
endmodule
