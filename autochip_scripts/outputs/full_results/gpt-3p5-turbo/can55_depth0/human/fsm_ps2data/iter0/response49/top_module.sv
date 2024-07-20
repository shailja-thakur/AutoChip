module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg done_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			done_next <= 0;
		end else begin
			case ({byte1, byte2, byte3})
				3'b000: begin
					if (in[3] == 1) begin
						byte1 <= in;
					end
				end
				3'b001: begin
					byte2 <= in;
				end
				3'b011: begin
					byte3 <= in;
					done_next <= 1;
				end
				default: begin
					byte1 <= 0;
					byte2 <= 0;
					byte3 <= 0;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			done <= 0;
		end else begin
			done <= done_next;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 0;
		end else if (done) begin
			out_bytes <= {byte3, byte2, byte1};
		end
	end

endmodule
