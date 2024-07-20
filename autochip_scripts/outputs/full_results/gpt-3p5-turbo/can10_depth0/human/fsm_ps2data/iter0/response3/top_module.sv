module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3] == 1) begin
					state <= 1;
					out_bytes[23:16] <= in;
				end
			end
			1: begin
				state <= 2;
				out_bytes[15:8] <= in;
			end
			2: begin
				state <= 3;
				out_bytes[7:0] <= in;
			end
			3: begin
				state <= 0;
				done <= 1;
			end
		endcase
	end
end

endmodule
