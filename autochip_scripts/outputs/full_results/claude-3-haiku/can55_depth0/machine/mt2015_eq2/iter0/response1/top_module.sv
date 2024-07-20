module top_module(
    input [1:0] A,
    input [1:0] B,
    output reg z
);

always @(*) begin
    z = (A == B) ? 1'b1 : 1'b0;
end

endmodule
