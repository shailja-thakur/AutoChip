module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    wire carry;

    always @(a or b) begin
        sum = a + b;
        carry = (a[7] && b[7]) || (a[7] && ~sum[7]) || (b[7] && ~sum[7]);
    end

    assign s = sum[7:0];
    assign overflow = carry;

endmodule
