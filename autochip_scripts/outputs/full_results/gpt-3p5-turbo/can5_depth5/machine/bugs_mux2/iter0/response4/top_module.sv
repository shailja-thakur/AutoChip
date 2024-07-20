module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

always @(sel, a, b) begin
    if (sel == 0)
        out <= b;
    else
        out <= a;
end

endmodule
