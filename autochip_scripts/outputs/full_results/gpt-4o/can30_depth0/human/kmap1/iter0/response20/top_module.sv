module top_module(
	input a, 
	input b,
	input c,
	output reg out
);

always @(*) begin
    case ({b, c})
        2'b00: out = a;
        2'b01, 2'b10, 2'b11: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
