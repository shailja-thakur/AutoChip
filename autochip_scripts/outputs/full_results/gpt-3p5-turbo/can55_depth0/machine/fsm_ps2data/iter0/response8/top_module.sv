module top_module (
input clk,
input [7:0] in,
input reset,
output [23:0] out_bytes,
output done
);

reg [23:0] out_bytes_reg;
reg [1:0] state;
reg done_reg;
reg clk_last;

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		out_bytes_reg <= 24'b0;
		state <= 2'b00;
		done_reg <= 1'b0;
		clk_last <= 1'b0;
	end else if (clk_last == 1'b0 && clk == 1'b1) begin
		out_bytes_reg <= done_reg ? (out_bytes_reg << 8) : out_bytes_reg;
		case (state)
			2'b00: begin
				state <= in[2] ? 2'b01 : 2'b00;
			end
			2'b01: begin
				state <= 2'b10;
			end
			2'b10: begin
				state <= 2'b11;
			end
			2'b11: begin
				state <= 2'b00;
			end
		endcase
		done_reg <= (state == 2'b11);
	end
	clk_last <= clk;
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;

endmodule
