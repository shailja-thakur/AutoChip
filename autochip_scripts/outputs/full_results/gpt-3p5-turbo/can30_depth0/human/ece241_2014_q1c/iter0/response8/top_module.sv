module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    reg overflow;

    always @(*) begin
        sum = a + b;
        if (sum > 127 || sum < -128) begin
            overflow = 1;
        end else begin
            overflow = 0;
        end
    end

    assign s = sum[7:0];

endmodule
