module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the counter values for each digit
parameter MAX_ONES = 9;
parameter MAX_TENS = 9;
parameter MAX_HUNDREDS = 9;
parameter MAX_THOUSANDS = 9;

// Counter values for each digit
reg [3:0] ones;
reg [3:0] tens;
reg [3:0] hundreds;
reg [3:0] thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
    end
    else begin
        // Increment the ones digit
        if (ones == MAX_ONES) begin
            ones <= 0;
            ena[1] = 1'b1; // Increment the tens digit
        end
        else begin
            ones <= ones + 1'b1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (ena[1]) begin
            if (tens == MAX_TENS) begin
                tens <= 0;
                ena[2] = 1'b1; // Increment the hundreds digit
            end
            else begin
                tens <= tens + 1'b1;
                ena[2] = 1'b0;
            end
        end

        // Increment the hundreds digit
        if (ena[2]) begin
            if (hundreds == MAX_HUNDREDS) begin
                hundreds <= 0;
                ena[3] = 1'b1; // Increment the thousands digit
            end
            else begin
                hundreds <= hundreds + 1'b1;
                ena[3] = 1'b0;
            end
        end

        // Increment the thousands digit
        if (ena[3]) begin
            if (thousands == MAX_THOUSANDS) begin
                thousands <= 0;
            end
            else begin
                thousands <= thousands + 1'b1;
            end
        end
    end

    // Assemble the 16-bit BCD counter value
    q = {thousands, hundreds, tens, ones};
end

endmodule
