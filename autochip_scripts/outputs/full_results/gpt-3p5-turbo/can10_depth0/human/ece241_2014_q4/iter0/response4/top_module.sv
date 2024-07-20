module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3, z;

assign q1 = d1 ^ q1;
assign q2 = ~d2 & q2;
assign q3 = ~d3 | q3;

assign z = ~(q1 ^ q2 ^ q3);

always @(posedge clk) begin
	if (rst) begin
		d1 <= 1'b0;
		d2 <= 1'b0;
		d3 <= 1'b0;
    end else begin
		d1 <= x;
		d2 <= ~q1;
		d3 <= ~q2;
	end
end

endmodule
