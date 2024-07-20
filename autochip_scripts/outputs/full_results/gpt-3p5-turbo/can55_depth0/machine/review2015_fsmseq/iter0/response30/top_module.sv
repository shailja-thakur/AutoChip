module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // reset to initial state (S)
		end else begin
			case(state)
				3'b000: begin // S
					if (data) begin
						state <= 3'b001; // S1
					end else begin
						state <= 3'b000; // S
					end
				end
				3'b001: begin // S1
					if (data) begin
						state <= 3'b011; // S11
					end else begin
						state <= 3'b000; // S
					end
				end
				3'b011: begin // S11
					if (data) begin
						state <= 3'b011; // S11
					end else begin
						state <= 3'b110; // S110
					end
				end
				3'b110: begin // S110
					if (data) begin
						state <= 3'b111; // Done
					end else begin
						state <= 3'b000; // S
					end
				end
				3'b111: begin // Done
					state <= 3'b111; // Done
				end
			endcase
		end
	end
	
	assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
