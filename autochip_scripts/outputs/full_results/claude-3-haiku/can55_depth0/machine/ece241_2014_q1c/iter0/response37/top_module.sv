module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output reg overflow
);

    wire [8:0] sum;

    // Calculate the 9-bit sum
    assign sum = a + b;

    // Assign the 8-bit output s
    assign s = sum[7:0];

    // Detect overflow
    always @(*) begin
        // If the two inputs have the same sign and the sign of the output is different,
        // then overflow has occurred
        overflow = (a[7] == b[7]) && (a[7] != sum[7]);
    end

endmodule
