module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	parameter S0 = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			start_shifting <= 0;
		end else begin
			case (state)
				S0: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= S0;
					end
				end
				S1: begin
					if (data) begin
						state <= S2;
					end else begin
						state <= S0;
					end
				end
				S2: begin
					if (data) begin
						state <= S3;
					end else begin
						state <= S0;
					end
				end
				S3: begin
					if (data) begin
						state <= S4;
					end else begin
						state <= S0;
					end
				end
				S4: begin
					if (data) begin
						start_shifting <= 1;
					end else begin
						state <= S0;
					end
				end
			endcase
		end
	end

endmodule
