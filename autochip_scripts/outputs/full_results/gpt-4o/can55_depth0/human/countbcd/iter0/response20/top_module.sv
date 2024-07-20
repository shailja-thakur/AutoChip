module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Split the 16-bit q register into four 4-bit BCD digits
    reg [3:0] ones, tens, hundreds, thousands;

    // Enable signals to indicate when each of the upper three digits should be incremented
    assign ena[1] = (ones == 4'd9);
    assign ena[2] = (tens == 4'd9) && ena[1];
    assign ena[3] = (hundreds == 4'd9) && ena[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // When reset is asserted, all BCD digits are set to 0
            ones <= 4'd0;
            tens <= 4'd0;
            hundreds <= 4'd0;
            thousands <= 4'd0;
        end else begin
            // Increment the ones digit
            if (ones == 4'd9) begin
                ones <= 4'd0;
                // Increment the tens digit
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    // Increment the hundreds digit
                    if (hundreds == 4'd9) begin
                        hundreds <= 4'd0;
                        // Increment the thousands digit
                        if (thousands == 4'd9) begin
                            thousands <= 4'd0;
                        end else begin
                            thousands <= thousands + 4'd1;
                        end
                    end else begin
                        hundreds <= hundreds + 4'd1;
                    end
                end else begin
                    tens <= tens + 4'd1;
                end
            end else begin
                ones <= ones + 4'd1;
            end
        end
    end

    // Concatenate the BCD digits to form the 16-bit output q
    always @(*) begin
        q = {thousands, hundreds, tens, ones};
    end
endmodule
