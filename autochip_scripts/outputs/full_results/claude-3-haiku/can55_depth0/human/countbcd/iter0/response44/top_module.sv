module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// 4-bit counters for each decimal digit
reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
        q <= 0;
    end
    else begin
        // Increment the ones digit
        if (ones == 9) begin
            ones <= 0;
            // Increment the tens digit when ones digit rolls over
            ena[1] = 1'b1;
            if (tens == 9) begin
                tens <= 0;
                // Increment the hundreds digit when tens digit rolls over
                ena[2] = 1'b1;
                if (hundreds == 9) begin
                    hundreds <= 0;
                    // Increment the thousands digit when hundreds digit rolls over
                    ena[3] = 1'b1;
                    if (thousands == 9) begin
                        thousands <= 0;
                    end
                    else begin
                        thousands <= thousands + 1;
                    end
                end
                else begin
                    hundreds <= hundreds + 1;
                end
            end
            else begin
                tens <= tens + 1;
            end
        end
        else begin
            ones <= ones + 1;
        end

        // Assemble the 16-bit BCD value
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
