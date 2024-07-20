module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] register;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		register <= 4'b0000;
	else
		register <= {register[2:0], in};
end

assign out = register[3];

endmodule
