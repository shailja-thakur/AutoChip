module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
    if ({c, a} == 2'b00) begin
        out = d;
    end else if ({c, a} == 2'b01) begin
        out = 1'b0;
    end else if ({c, a} == 2'b10) begin
        out = 1'b1;
    end else if ({c, a} == 2'b11) begin
        out = 1'b1;
    end
end

endmodule
