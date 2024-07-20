module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;

    always @ (a or b) begin
        sum = a + b;
    end

    assign s = sum[7:0];
    assign overflow = sum[8];

endmodule
