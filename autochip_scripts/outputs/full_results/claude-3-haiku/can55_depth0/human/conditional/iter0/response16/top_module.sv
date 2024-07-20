module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always @(*) begin
    min = a;
    if (b < min) begin
        min = b;
    end
    if (c < min) begin
        min = c;
    end
    if (d < min) begin
        min = d;
    end
end

endmodule
