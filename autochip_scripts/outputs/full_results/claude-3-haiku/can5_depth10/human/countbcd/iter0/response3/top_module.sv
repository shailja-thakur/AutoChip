module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the BCD digit values
parameter ONES = 0, TENS = 4, HUNDREDS = 8, THOUSANDS = 12;

// Increment the BCD digits
always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment the ones digit
        if (q[ONES+3:ONES] == 4'd9) begin
            q[ONES+3:ONES] <= 4'd0;
            ena[1] <= 1'b1;
        end
        else begin
            q[ONES+3:ONES] <= q[ONES+3:ONES] + 1'b1;
            ena[1] <= 1'b0;
        end

        // Increment the tens digit
        if (q[TENS+3:TENS] == 4'd9 && ena[1]) begin
            q[TENS+3:TENS] <= 4'd0;
            ena[2] <= 1'b1;
        end
        else begin
            q[TENS+3:TENS] <= q[TENS+3:TENS] + ena[1];
            ena[2] <= 1'b0;
        end

        // Increment the hundreds digit
        if (q[HUNDREDS+3:HUNDREDS] == 4'd9 && ena[2]) begin
            q[HUNDREDS+3:HUNDREDS] <= 4'd0;
            ena[3] <= 1'b1;
        end
        else begin
            q[HUNDREDS+3:HUNDREDS] <= q[HUNDREDS+3:HUNDREDS] + ena[2];
            ena[3] <= 1'b0;
        end

        // Increment the thousands digit
        if (q[THOUSANDS+3:THOUSANDS] == 4'd9 && ena[3]) begin
            q[THOUSANDS+3:THOUSANDS] <= 4'd0;
        end
        else begin
            q[THOUSANDS+3:THOUSANDS] <= q[THOUSANDS+3:THOUSANDS] + ena[3];
        end
    end
end

endmodule
