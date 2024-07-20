module top_module (
	input clk,
	input in,
	output logic out
);

logic prev_out;

always @(posedge clk)
begin
    out <= in ^ prev_out;
    prev_out <= out;
end

endmodule
