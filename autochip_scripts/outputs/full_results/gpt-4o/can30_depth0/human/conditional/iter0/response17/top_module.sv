module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

reg [7:0] min1;
reg [7:0] min2;

always @(*) begin
    if (a < b)
        min1 = a;
    else
        min1 = b;

    if (c < d)
        min2 = c;
    else
        min2 = d;

    if (min1 < min2)
        min = min1;
    else
        min = min2;
end

endmodule
