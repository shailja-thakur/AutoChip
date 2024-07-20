module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg done;
reg [7:0] prev_byte;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		done <= 0;
		prev_byte <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					prev_byte <= in;
					state <= 1;
				end
			end
			1: begin
				prev_byte <= in;
				state <= 2;
			end
			2: begin
				if (in[3] == 1) begin
					done <= 1;
					state <= 0;
				end else begin
					prev_byte <= in;
					state <= 1;
				end
			end
			default: state <= 0;
		endcase
	end
end

endmodule
