module top_module (
	input clk,
	input a, 
	output reg q
);

always @(posedge clk) begin
    if (a == 0) begin
        q <= 0;
    end else begin
        q <= ~q;
    end
end

endmodule
