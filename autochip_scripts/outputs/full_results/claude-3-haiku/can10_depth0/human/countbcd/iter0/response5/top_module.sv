module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Declare internal registers for each BCD digit
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
        q <= 0;
    end
    else begin
        // Increment the ones digit
        if (ones == 4'b1001) begin
            ones <= 0;
            // Increment the tens digit
            if (tens == 4'b1001) begin
                tens <= 0;
                // Increment the hundreds digit
                if (hundreds == 4'b1001) begin
                    hundreds <= 0;
                    // Increment the thousands digit
                    if (thousands == 4'b1001) begin
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

        // Combine the BCD digits into the output
        q <= {thousands, hundreds, tens, ones};
    end
end

// Generate the enable signals for the upper three digits
assign ena[1] = (ones == 4'b1001);
assign ena[2] = (tens == 4'b1001);
assign ena[3] = (hundreds == 4'b1001);

endmodule
