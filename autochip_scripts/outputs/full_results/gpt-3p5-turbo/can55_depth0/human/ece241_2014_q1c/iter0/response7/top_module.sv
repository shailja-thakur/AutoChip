module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    reg sign_a, sign_b, sign_sum;

    always @* begin
        // Determine the sign of a, b, and sum
        sign_a = a[7];
        sign_b = b[7];
        sign_sum = sum[8];
        
        // Calculate the sum
        sum = a + b;

        // Determine if overflow has occurred
        if (sign_a == sign_b && sign_sum != sign_a) begin
            overflow = 1;
        end else begin
            overflow = 0;
        end
    end

    assign s = sum[7:0];

endmodule
