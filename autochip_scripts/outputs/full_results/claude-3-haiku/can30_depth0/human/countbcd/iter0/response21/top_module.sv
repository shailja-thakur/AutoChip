module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the maximum value for the BCD counter
parameter MAX_COUNT = 9999;

// Define the bit positions for each decimal digit
localparam ONES   = 3:0;
localparam TENS   = 7:4;
localparam HUNDREDS = 11:8;
localparam THOUSANDS = 15:12;

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        // Increment the ones digit
        q[ONES] <= (q[ONES] == 9) ? 0 : q[ONES] + 1;

        // Increment the tens digit when the ones digit rolls over
        if (q[ONES] == 9) begin
            q[TENS] <= (q[TENS] == 9) ? 0 : q[TENS] + 1;
            ena[1] <= 1;
        end
        else begin
            ena[1] <= 0;
        end

        // Increment the hundreds digit when the tens digit rolls over
        if (q[TENS] == 9) begin
            q[HUNDREDS] <= (q[HUNDREDS] == 9) ? 0 : q[HUNDREDS] + 1;
            ena[2] <= 1;
        end
        else begin
            ena[2] <= 0;
        end

        // Increment the thousands digit when the hundreds digit rolls over
        if (q[HUNDREDS] == 9) begin
            q[THOUSANDS] <= (q[THOUSANDS] == 9) ? 0 : q[THOUSANDS] + 1;
            ena[3] <= 1;
        end
        else begin
            ena[3] <= 0;
        end

        // Wrap around to 0 when the counter reaches the maximum value
        if (q == MAX_COUNT) begin
            q <= 0;
        end
    end
end

endmodule
