module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
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
						state <= 3'b001;
				end
				3'b010: begin
					if (shift_ena)
						state <= 3'b011;
					else
						state <= 3'b010;
				end
				3'b011: begin
					if (shift_ena)
						state <= 3'b100;
					else
						state <= 3'b011;
				end
				default: state <= 3'b100;
			endcase
		end
	end

	assign shift_ena = (state != 3'b000);

endmodule
