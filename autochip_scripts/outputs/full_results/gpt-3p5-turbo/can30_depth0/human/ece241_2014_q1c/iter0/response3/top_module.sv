module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    assign s = sum[7:0];
    assign overflow = sum[8] ^ sum[7];

    always @(*) begin
        sum = a + b;
    end

endmodule
