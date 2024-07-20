module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
always_ff @(posedge clk)
begin
	data <= in;
end

always @(*)
begin
    out <= data;
end

endmodule
