module top_module (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    if (sel == 0)
        out = a;
    else
        out = b;
end

endmodule
