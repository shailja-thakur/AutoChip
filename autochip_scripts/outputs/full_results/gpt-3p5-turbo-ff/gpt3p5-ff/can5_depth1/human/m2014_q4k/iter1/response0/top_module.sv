module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
wire [3:0] d_next;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		d <= 4'b0000;
	else
		d <= d_next;
end

assign d_next = {d[2:0], in};
assign out = d[3];

endmodule
