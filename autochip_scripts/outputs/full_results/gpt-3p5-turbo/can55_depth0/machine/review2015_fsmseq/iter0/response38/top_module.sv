module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	parameter S = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S11 = 4'b0010;
	parameter S110 = 4'b0011;
	parameter Done = 4'b0100;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S;
		end else begin
			case (state)
				S: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= S;
					end
				end
				S1: begin
					if (data) begin
						state <= S11;
					end else begin
						state <= S;
					end
				end
				S11: begin
					if (data) begin
						state <= S11;
					end else begin
						state <= S110;
					end
				end
				S110: begin
					if (data) begin
						state <= Done;
					end else begin
						state <= S;
					end
				end
				Done: begin
					state <= Done;
				end
			endcase
		end
	end

	always @(state) begin
		if (state == Done) begin
			start_shifting = 1'b1;
		end else begin
			start_shifting = 1'b0;
		end
	end

endmodule
