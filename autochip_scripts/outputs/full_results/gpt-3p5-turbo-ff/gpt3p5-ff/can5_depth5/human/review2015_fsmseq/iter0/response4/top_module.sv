module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [3:0] state;
	parameter IDLE = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= IDLE;
					end
				end
				S1: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= S2;
					end
				end
				S2: begin
					if (data) begin
						state <= S3;
					end else begin
						state <= IDLE;
					end
				end
				S3: begin
					if (data) begin
						state <= S1;
						start_shifting <= 1;
					end else begin
						state <= S2;
					end
				end
			endcase
		end
	end
	
endmodule
