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
reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
	end else begin
		case (state)
			3'd0:
				if (in[3] == 1'b1) begin
					state <= 3'd1;
					byte1 <= in;
				end
			3'd1:
				state <= 3'd2;
				byte2 <= in;
			3'd2:
				state <= 3'd3;
				byte3 <= in;
			3'd3:
				state <= 3'd0;
		endcase
	end
end

assign out_bytes = {byte1, byte2, byte3};
assign done = (state == 3'd3);

endmodule
