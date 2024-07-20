module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state;
	reg [3:0] count;

	always @(posedge clk) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: begin
					if (count == 4'b101)
						state <= 1;
					else
						count <= count + 1;
				end
				1: begin
					state <= 2;
				end
				2: begin
					state <= 3;
				end
				3: begin
					state <= 4;
				end
				4: begin
					state <= 0;
				end
				default: begin
					state <= 0;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset)
			count <= 0;
		else if (state == 1)
			count <= 4;
		else if (state == 4)
			count <= 0;
	end

	assign shift_ena = (state == 1 || state == 2 || state == 3 || state == 4);

endmodule
