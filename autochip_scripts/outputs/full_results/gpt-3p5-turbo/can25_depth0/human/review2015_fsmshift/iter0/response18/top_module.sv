module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg shift_ena;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
			shift_ena <= 1'b1;
		end else begin
			case (state)
				3'b000: begin
					if (bit_pattern_detected) begin
						shift_ena <= 1'b1;
						state <= 3'b001;
					end else begin
						shift_ena <= 1'b0;
						state <= 3'b000;
					end
				end
				3'b001: begin
					shift_ena <= 1'b1;
					state <= 3'b010;
				end
				3'b010: begin
					shift_ena <= 1'b1;
					state <= 3'b011;
				end
				3'b011: begin
					shift_ena <= 1'b1;
					state <= 3'b100;
				end
				default: begin
					shift_ena <= 1'b0;
					state <= 3'b000;
				end
			endcase
		end
	end

endmodule
