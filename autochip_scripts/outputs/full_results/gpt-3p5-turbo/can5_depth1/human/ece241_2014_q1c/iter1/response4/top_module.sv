module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

// Declare a temporary variable to hold the sum
reg [8:0] temp;

always @(*) begin
    // Add the two numbers
    temp = a + b;

    // Check for overflow
    if (temp[8] == 1) begin
        overflow = 1;
    end else begin
        overflow = 0;
    end

    // Assign the sum to the output
    s = temp[7:0];
end

endmodule
