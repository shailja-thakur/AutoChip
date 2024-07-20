module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin
				if (in[2] == 1'b1)
					state <= 2'b01;
			end
			2'b01: begin
				state <= 2'b10;
			end
			2'b10: begin
				state <= 2'b11;
			end
			2'b11: begin
				if (in[2] == 1'b0)
					state <= 2'b00;
				else
					state <= 2'b01;
			end
		endcase
		end
	end

	always @(state) begin
		if (state == 2'b11)
			done <= 1'b1;
		else
			done <= 1'b0;
	end
endmodule
