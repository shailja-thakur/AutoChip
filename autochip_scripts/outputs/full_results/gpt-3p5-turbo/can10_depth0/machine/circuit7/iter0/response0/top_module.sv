module top_module (
	input clk,
	input a, 
	output reg q
);
//use always_ff for synchronous logic
always_ff @(posedge clk) begin
    q <= ~a;
end
endmodule
