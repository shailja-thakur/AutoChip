module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] dff;

always @(posedge clk or negedge resetn)
begin
	if (!resetn)
		dff <= 0;
	else
		dff <= {dff[2:0], in};
end

assign out = dff[3];

endmodule
