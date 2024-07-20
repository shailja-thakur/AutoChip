module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	parameter IDLE = 4'b0000;
	parameter S0 = 4'b0001;
	parameter S1 = 4'b0010;
	parameter S2 = 4'b0100;
	parameter S3 = 4'b1000;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					if (data == 1'b1) begin
						state <= S0;
					end else begin
						state <= IDLE;
					end
				end
				S0: begin
					if (data == 1'b1) begin
						state <= S0;
					end else begin
						state <= S1;
					end
				end
				S1: begin
					if (data == 1'b0) begin
						state <= S2;
					end else begin
						state <= IDLE;
					end
				end
				S2: begin
					if (data == 1'b1) begin
						state <= S1;
					end else begin
						state <= S3;
					end
				end
				S3: begin
					if (data == 1'b0) begin
						state <= S2;
						start_shifting <= 1;
					end else begin
						state <= S1;
					end
				end
			endcase
		end
	end

endmodule
