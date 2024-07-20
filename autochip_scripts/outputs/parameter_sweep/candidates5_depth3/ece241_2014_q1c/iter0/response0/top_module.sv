module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    reg [8:0] sum;
    reg signed [7:0] a_signed;
    reg signed [7:0] b_signed;

    always @* begin
        a_signed = $signed(a);
        b_signed = $signed(b);
        sum = a_signed + b_signed;
        overflow = (sum > 127) || (sum < -128);
        s = sum[7:0];
    end

endmodule
