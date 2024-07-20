module top_module (
    input  wire a,
    input  wire b,
    output reg sum,
    output reg cout
);

always @(a, b) begin
    {cout, sum} = a + b;
end

endmodule
