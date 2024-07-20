module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output reg overflow
);

    reg [8:0] sum;

    always @(*) begin
        sum = a + b;
        if (sum > 255 || sum < -256)
            overflow = 1;
        else
            overflow = 0;
        s = sum[7:0];
    end

endmodule
