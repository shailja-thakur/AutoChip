module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [1:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg [23:0] out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			out <= 24'b0;
		end else begin
			case (state)
				2'b00: begin
					if (in[3] == 1) begin
						state <= 2'b01;
						byte1 <= in;
					end
				end
				2'b01: begin
					state <= 2'b10;
					byte2 <= in;
				end
				2'b10: begin
					state <= 2'b11;
					byte3 <= in;
				end
				default: begin
					state <= 2'b00;
					byte1 <= 8'b0;
					byte2 <= 8'b0;
					byte3 <= 8'b0;
					out <= 24'b0;
				end
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			done <= 0;
			out_bytes <= 24'b0;
		end else begin
			if (state == 2'b11) begin
				done <= 1;
				out_bytes <= {byte1, byte2, byte3};
			end else begin
				done <= 0;
				out_bytes <= 24'b0;
			end
		end
	end

endmodule
