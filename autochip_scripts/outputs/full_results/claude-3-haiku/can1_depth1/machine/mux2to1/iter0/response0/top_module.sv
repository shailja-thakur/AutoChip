module top_module (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    if (sel == 1'b1)
        out = b;
    else
        out = a;
end

endmodule
