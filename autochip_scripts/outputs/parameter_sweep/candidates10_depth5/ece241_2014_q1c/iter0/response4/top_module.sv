module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    reg signed [7:0] a_s, b_s;
    reg signed [8:0] sum_s;

    always @(*) begin
        a_s = a;
        b_s = b;
        sum_s = a_s + b_s;
        sum = sum_s[7:0];
        overflow = (sum_s[8] == 1);
    end

    assign s = sum;

endmodule
