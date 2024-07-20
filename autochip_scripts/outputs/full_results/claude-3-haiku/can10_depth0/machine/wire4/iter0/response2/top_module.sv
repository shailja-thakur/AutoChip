module top_module (
    input a,
    input b,
    input c,
    output reg w,
    output reg x,
    output reg y,
    output reg z
);

always @(*) begin
    w <= a;
    x <= b;
    y <= b;
    z <= c;
end

endmodule
