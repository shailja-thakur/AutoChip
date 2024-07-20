module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] currentState;
	parameter S0 = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;

	always @(posedge clk or posedge reset) begin
		if (reset)
			currentState <= S0;
		else begin
			case (currentState)
				S0: begin
					if (data)
						currentState <= S1;
				end
				S1: begin
					if (data)
						currentState <= S2;
					else
						currentState <= S0;
				end
				S2: begin
					if (data)
						currentState <= S3;
					else
						currentState <= S0;
				end
				S3: begin
					if (data)
						start_shifting <= 1;
					else
						currentState <= S4;
				end
				S4: begin
					if (data)
						currentState <= S3;
					else
						currentState <= S0;
				end
			endcase
		end
	end
endmodule
