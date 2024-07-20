module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

parameter ONES_BITS = 3:0;
parameter TENS_BITS = 7:4;
parameter HUNDREDS_BITS = 11:8;
parameter THOUSANDS_BITS = 15:12;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        // Increment the ones digit
        q[ONES_BITS] <= (q[ONES_BITS] == 4'b1001) ? 4'b0000 : q[ONES_BITS] + 1;

        // Increment the tens digit when the ones digit overflows
        if (q[ONES_BITS] == 4'b1001) begin
            q[TENS_BITS] <= (q[TENS_BITS] == 4'b1001) ? 4'b0000 : q[TENS_BITS] + 1;
            ena[1] <= 1;
        end
        else begin
            ena[1] <= 0;
        end

        // Increment the hundreds digit when the tens digit overflows
        if (q[TENS_BITS] == 4'b1001) begin
            q[HUNDREDS_BITS] <= (q[HUNDREDS_BITS] == 4'b1001) ? 4'b0000 : q[HUNDREDS_BITS] + 1;
            ena[2] <= 1;
        end
        else begin
            ena[2] <= 0;
        end

        // Increment the thousands digit when the hundreds digit overflows
        if (q[HUNDREDS_BITS] == 4'b1001) begin
            q[THOUSANDS_BITS] <= (q[THOUSANDS_BITS] == 4'b1001) ? 4'b0000 : q[THOUSANDS_BITS] + 1;
            ena[3] <= 1;
        end
        else begin
            ena[3] <= 0;
        end
    end
end

endmodule
