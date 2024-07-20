module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the maximum value for the BCD counter
localparam MAX_VALUE = 9999;

// Define the bit positions for each digit
localparam ONES_DIGIT   = 3:0;
localparam TENS_DIGIT   = 7:4;
localparam HUNDREDS_DIGIT = 11:8;
localparam THOUSANDS_DIGIT = 15:12;

// Increment the ones digit
always @(posedge clk) begin
    if (reset) begin
        q[ONES_DIGIT] <= 0;
    end else if (q[ONES_DIGIT] == 9) begin
        q[ONES_DIGIT] <= 0;
        ena[1] <= 1;
    end else begin
        q[ONES_DIGIT] <= q[ONES_DIGIT] + 1;
        ena[1] <= 0;
    end
end

// Increment the tens digit
always @(posedge clk) begin
    if (reset) begin
        q[TENS_DIGIT] <= 0;
    end else if (q[TENS_DIGIT] == 9 && q[ONES_DIGIT] == 9) begin
        q[TENS_DIGIT] <= 0;
        ena[2] <= 1;
    end else if (ena[1]) begin
        q[TENS_DIGIT] <= q[TENS_DIGIT] + 1;
        ena[2] <= 0;
    end
end

// Increment the hundreds digit
always @(posedge clk) begin
    if (reset) begin
        q[HUNDREDS_DIGIT] <= 0;
    end else if (q[HUNDREDS_DIGIT] == 9 && q[TENS_DIGIT] == 9 && q[ONES_DIGIT] == 9) begin
        q[HUNDREDS_DIGIT] <= 0;
        ena[3] <= 1;
    end else if (ena[2]) begin
        q[HUNDREDS_DIGIT] <= q[HUNDREDS_DIGIT] + 1;
        ena[3] <= 0;
    end
end

// Increment the thousands digit
always @(posedge clk) begin
    if (reset) begin
        q[THOUSANDS_DIGIT] <= 0;
    end else if (q[THOUSANDS_DIGIT] == 9 && q[HUNDREDS_DIGIT] == 9 && q[TENS_DIGIT] == 9 && q[ONES_DIGIT] == 9) begin
        q[THOUSANDS_DIGIT] <= 0;
    end else if (ena[3]) begin
        q[THOUSANDS_DIGIT] <= q[THOUSANDS_DIGIT] + 1;
    end
end

endmodule
