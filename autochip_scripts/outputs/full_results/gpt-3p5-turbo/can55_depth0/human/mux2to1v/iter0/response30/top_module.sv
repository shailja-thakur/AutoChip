module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output reg [99:0] out
);

always @* begin
    if (sel)
        out <= b;
    else
        out <= a;
end

endmodule
