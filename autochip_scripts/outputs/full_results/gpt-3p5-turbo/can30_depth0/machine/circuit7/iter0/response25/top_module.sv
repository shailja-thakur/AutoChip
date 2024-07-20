module top_module (
	input wire clk,
	input wire a, 
	output reg q
);

always @(posedge clk) begin
	q <= ~a;
end

endmodule
