module top_module (
	input clk,
	input in,
	output logic out
);

// D flip-flop
reg d;

always @(posedge clk) begin
    d <= in ^ out;
end

assign out = d;

endmodule
