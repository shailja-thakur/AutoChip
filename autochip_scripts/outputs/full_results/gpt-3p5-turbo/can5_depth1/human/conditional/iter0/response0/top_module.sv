module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

reg [7:0] temp_min;

always @(a, b, c, d) begin
    if (a < b && a < c && a < d)
        temp_min = a;
    else if (b < c && b < d)
        temp_min = b;
    else if (c < d)
        temp_min = c;
    else
        temp_min = d;
end

always @(posedge clk) begin
    min <= temp_min;
end

endmodule
