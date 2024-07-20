module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	always @(posedge clk) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: begin
					if (shift_ena)
						state <= 3'b001;
					else 
						state <= 3'b000;
				end
				3'b001: begin
					if (shift_ena)
						state <= 3'b010;
					else 
						state <= 3'b000;
				end
				3'b010: begin
					if (shift_ena)
						state <= 3'b011;
					else 
						state <= 3'b000;
				end
				3'b011: begin
					if (shift_ena)
						state <= 3'b100;
					else 
						state <= 3'b000;
				end
				3'b100: begin
					state <= 3'b101;
				end
				3'b101: begin
					state <= 3'b110;
				end
				3'b110: begin
					state <= 3'b111;
				end
				3'b111: begin
					state <= 3'b111;
				end
				default: begin
					state <= 3'b111;
				end
			endcase
		end
	end

	assign shift_ena = (state != 3'b000) && (state != 3'b111);

endmodule
