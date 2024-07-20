module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State variables
	reg [2:0] state;
	reg start_shifting;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000; // Initial state S
		end else begin
			case (state)
				3'b000: begin // State S
					if (data) begin
						state <= 3'b001; // Next state S1
					end
				end
				3'b001: begin // State S1
					if (data) begin
						state <= 3'b011; // Next state S11
					end else begin
						state <= 3'b000; // Next state S
					end
				end
				3'b011: begin // State S11
					if (data) begin
						state <= 3'b011; // Next state S11
					end else begin
						state <= 3'b110; // Next state S110
					end
				end
				3'b110: begin // State S110
					if (data) begin
						state <= 3'b111; // Next state Done
					end else begin
						state <= 3'b000; // Next state S
					end
				end
				3'b111: begin // State Done
					state <= 3'b111; // Next state Done
				end
			endcase
		end
	end

	// Output assignment
	assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
