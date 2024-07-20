module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire z;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'h0;
	else begin
		case ({w, state})
			2'b00_000: state <= 3'h0;
			2'b01_001: state <= 3'h1;
			2'b10_010: state <= 3'h2;
			2'b01_011: state <= 3'h3;
			2'b10_100: state <= 3'h4;
			2'b10_101: state <= 3'h4;
			2'b01_110: state <= 3'h5;
			2'b10_111: state <= 3'h2;
			default: state <= 3'h0;
		endcase
	end
end

assign z = (state == 3'h4) || (state == 3'h5);

endmodule
