module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
    if (state) begin
        q <= a & b;
    end else begin
        q <= 1'b0;
    end
    
    if (a == 1'b0 && b == 1'b1) begin
        state <= 1'b1;
    end else if (a == 1'b1 && b == 1'b0) begin
        state <= 1'b0;
    end
end

endmodule
