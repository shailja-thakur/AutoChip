module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
reg [3:0] next_d;
wire reset;

assign reset = ~resetn;

assign out = d[0];

always @(posedge clk or negedge reset) begin
	if (!reset)
		next_d <= 4'b0;
	else
		next_d <= {d[2:0], in};
end

always @(posedge clk or negedge reset) begin
	if (!reset)
		d <= 4'b0;
	else
		d <= next_d;
end

endmodule
