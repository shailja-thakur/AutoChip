module top_module (
    input [2:0] in,
    output [1:0] out
);
    // Define intermediate wire to store the addition result
    wire [2:0] sum;

    // Perform addition operation
    assign sum = in + in;

    // Assign output bits from the addition result
    assign out[1] = sum[2];
    assign out[0] = sum[1];

endmodule
