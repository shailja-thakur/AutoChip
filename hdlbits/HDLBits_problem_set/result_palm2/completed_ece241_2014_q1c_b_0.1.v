module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] s;
    reg overflow;

    always @(posedge clk) begin
        s <= a + b;
        overflow <= (s[7] & (a[7] ^ b[7]));
    end

endmodule