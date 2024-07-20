module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
reg [3:0] q;
always @(posedge clk or negedge resetn) begin
	if (!resetn)
		q <= 4'b0000;
	else begin
		d[3] <= in;
		d[2] <= d[3];
		d[1] <= d[2];
		d[0] <= d[1];
		q <= d;
	end
end

assign out = q[0];

endmodule
