module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Declare internal signals
reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
    end
    else begin
        // Increment the ones digit
        if (ones == 9) begin
            ones <= 0;
            // Increment the tens digit
            if (tens == 9) begin
                tens <= 0;
                // Increment the hundreds digit
                if (hundreds == 9) begin
                    hundreds <= 0;
                    // Increment the thousands digit
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
    end
end

// Assign the output signals
assign q = {thousands, hundreds, tens, ones};
assign ena[1] = (tens != 0 || hundreds != 0 || thousands != 0);
assign ena[2] = (hundreds != 0 || thousands != 0);
assign ena[3] = (thousands != 0);

endmodule
