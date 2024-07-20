module top_module (
	input clk,
	input in,
	output logic out
);

reg data;
always_ff @(posedge clk)
begin
    if (clk)
        data <= in;
    out <= data;
end

endmodule
