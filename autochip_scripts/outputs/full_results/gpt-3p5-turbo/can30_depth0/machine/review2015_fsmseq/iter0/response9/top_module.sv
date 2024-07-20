module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [3:0] state;     // state register
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 4'b0000;   // S state
		end else begin
			case (state)
				4'b0000: begin
					if (data) begin
						state <= 4'b0001;   // S1 state
					end
				end
				4'b0001: begin
					if (data) begin
						state <= 4'b0011;   // S11 state
					end else begin
						state <= 4'b0000;   // S state
					end
				end
				4'b0011: begin
					if (data) begin
						state <= 4'b0011;   // S11 state
					end else begin
						state <= 4'b0110;   // S110 state
					end
				end
				4'b0110: begin
					if (data) begin
						state <= 4'b1111;   // Done state
					end else begin
						state <= 4'b0000;   // S state
					end
				end
				4'b1111: begin
					state <= 4'b1111;   // Done state
				end
			endcase
		end
	end
	
	assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;
	
endmodule
