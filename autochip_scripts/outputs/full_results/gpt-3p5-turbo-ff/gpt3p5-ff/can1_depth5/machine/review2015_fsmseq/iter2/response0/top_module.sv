module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// state definition
	reg [2:0] state;
	// output assignment
	assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000; // reset state
		end else begin
			case (state)
				3'b000: begin // S state
					if (data) begin
						state <= 3'b001; // S1 state
					end else begin
						state <= 3'b000; // Stay in S state
					end
				end
				3'b001: begin // S1 state
					if (data) begin
						state <= 3'b011; // S11 state
					end else begin
						state <= 3'b000; // Go back to S state
					end
				end
				3'b011: begin // S11 state
					if (data) begin
						state <= 3'b011; // Stay in S11 state
					end else begin
						state <= 3'b110; // Go to S110 state
					end
				end
				3'b110: begin // S110 state
					if (data) begin
						state <= 3'b111; // Done state
					end else begin
						state <= 3'b000; // Go back to S state
					end
				end
				3'b111: begin // Done state
					state <= 3'b111; // Stay in Done state
				end
			endcase
		end
	end
endmodule
