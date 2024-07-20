module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [7:0] byte_1;
	reg [7:0] byte_2;
	reg [7:0] byte_3;
	reg [2:0] state;
	reg done_out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			byte_1 <= 8'd0;
			byte_2 <= 8'd0;
			byte_3 <= 8'd0;
			done_out <= 0;
			out_bytes <= 24'd0;
		end else begin
			case (state)
				0: begin
					if (in[3] == 1) begin
						byte_1 <= in;
						state <= 1;
					end
				end
				1: begin
					byte_2 <= in;
					state <= 2;
				end
				2: begin
					byte_3 <= in;
					state <= 0;
					done_out <= 1;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			done <= 0;
		end else begin
			done <= done_out;
		end
	end

	always @(posedge clk) begin
		if (done_out) begin
			out_bytes <= {byte_1, byte_2, byte_3};
		end
	end

endmodule
