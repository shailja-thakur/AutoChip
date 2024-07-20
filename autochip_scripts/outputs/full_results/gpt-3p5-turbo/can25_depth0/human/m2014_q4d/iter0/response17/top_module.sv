module top_module (
	input clk,
	input in,
	output logic out
);

logic d;
logic q;

assign q = out;

always_ff @(posedge clk)
begin
	d <= in ^ q;
end

endmodule
