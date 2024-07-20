module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d;
reg out;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		d <= 4'b0000;
		out <= 1'b0;
	end else begin
		d <= {in, d[3:1]};
		out <= d[0];
	end
end

endmodule
