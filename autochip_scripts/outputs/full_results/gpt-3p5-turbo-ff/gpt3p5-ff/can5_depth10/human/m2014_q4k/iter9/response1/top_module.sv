module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
wire reset;

assign reset = ~resetn;

assign out = d[0];

always @(posedge clk, posedge reset) begin
	if (!reset)
		d <= 4'b0;
	else
		d <= {d[2:0], in};
end

endmodule
