module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00;
		out_bytes <= 24'b0;
		done <= 0;
	end else begin
		case (state)
			2'b00: begin
				if (in[3] == 1) begin
					byte1 <= in;
					state <= 2'b01;
				end
			end
			2'b01: begin
				byte2 <= in;
				state <= 2'b10;
			end
			2'b10: begin
				byte3 <= in;
				state <= 2'b11;
			end
			2'b11: begin
				out_bytes <= {byte1, byte2, byte3};
				done <= 1;
				state <= 2'b00;
			end
			default: begin
				state <= 2'b00;
			end
		endcase
	end
end

endmodule
