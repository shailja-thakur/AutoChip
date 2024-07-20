module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;

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
						state <= S1;
					else
						state <= S2;
				end
				S2: begin
					if (data)
						state <= S3;
					else
						state <= S0;
				end
				S3: begin
					if (data)
						state <= S1;
					else
						state <= S2;
				end
			endcase
		end
	end

	assign start_shifting = (state == S3);

endmodule
