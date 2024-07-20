module top_module (
	input clk,
	input a, 
	output reg q
);

reg flag;

always @(posedge clk) begin
    if (a) begin
        q <= 0;
    end else if (!a && flag) begin
        q <= 1;
    end
    flag <= !flag;
end

endmodule
