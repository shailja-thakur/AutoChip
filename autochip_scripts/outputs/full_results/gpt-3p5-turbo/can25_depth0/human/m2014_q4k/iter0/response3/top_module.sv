module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
reg [3:0] q;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		d <= 4'b0;
	end else begin
		d <= {q[2:0], in};
	end
end

assign out = q[3];

endmodule
