module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output reg overflow
);

    wire [8:0] sum;

    assign sum = a + b;
    assign s = sum[7:0];

    always @(*) begin
        overflow = (a[7] == b[7]) && (sum[7] != a[7]);
    end

endmodule
