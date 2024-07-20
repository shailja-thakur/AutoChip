module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);
	// Define states
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;

	reg [2:0] state;
	reg [3:0] shift_reg;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (data)
						state <= S1;
					else
						state <= S0;
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
					if (data) begin
						state <= S4;
						start_shifting <= 1;
					end
					else begin
						state <= S0;
						start_shifting <= 0;
					end
				end
			endcase
		end
	end
endmodule
