module top_module (
    input signed [7:0] a,
    input signed [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

    // Internal Signal to hold intermediate addition result
    reg signed [8:0] sum;

    always @* begin
        // Perform addition
        sum = a + b;

        // Check for overflow
        if (sum[8] != sum[7])
            overflow = 1;
        else
            overflow = 0;

        // Assign sum to output s[7:0]
        s = sum[7:0];
    end

endmodule
