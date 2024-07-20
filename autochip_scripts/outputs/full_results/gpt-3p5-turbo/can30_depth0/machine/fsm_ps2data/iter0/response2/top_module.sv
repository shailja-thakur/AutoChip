module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] out_bytes_reg;
reg done_reg;
wire [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= BYTE1;
	else
		state <= next_state;
end

always @(state, in) begin
	case (state)
		BYTE1: begin
			next_state = (in[2] == 1'b1) ? BYTE2 : BYTE1;
			done_reg = 0;
			out_bytes_reg = {out_bytes_reg[15:0], in};
		end
		BYTE2: begin
			next_state = BYTE3;
			done_reg = 0;
			out_bytes_reg = {out_bytes_reg[15:0], in};
		end
		BYTE3: begin
			next_state = DONE;
			done_reg = 0;
			out_bytes_reg = {out_bytes_reg[15:0], in};
		end
		DONE: begin
			next_state = (in[2] == 1'b0) ? BYTE1 : DONE;
			done_reg = 1;
		end
	endcase
end

assign out_bytes = done_reg ? out_bytes_reg : 0;

assign done = done_reg;

endmodule
