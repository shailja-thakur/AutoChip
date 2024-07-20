module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1, byte2, byte3;
reg done_reg;
reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
		done_reg <= 0;
	end else begin
		case (state)
			0: begin
				if (in[3]) begin
					state <= 1;
					byte1 <= in;
				end
			end
			1: begin
				state <= 2;
				byte2 <= in;
			end
			2: begin
				state <= 3;
				byte3 <= in;
			end
			3: begin
				state <= 0;
				done_reg <= 1;
			end
		endcase
	end
end

assign out_bytes = {byte1, byte2, byte3};
assign done = done_reg;

endmodule
