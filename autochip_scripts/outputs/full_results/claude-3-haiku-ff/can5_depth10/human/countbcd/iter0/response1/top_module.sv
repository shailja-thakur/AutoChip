module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    // Declare internal signals
    reg [3:0] ones, tens, hundreds, thousands;

    // Assign enable signals
    assign ena[1] = (tens == 4'b1001);
    assign ena[2] = (hundreds == 4'b1001);
    assign ena[3] = (thousands == 4'b1001);

    // Synchronous counter logic
    always @(posedge clk) begin
        if (reset) begin
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
        end
        else begin
            // Increment ones digit
            if (ones == 4'b1001) begin
                ones <= 0;
                // Increment tens digit if ones digit is 9
                if (tens == 4'b1001) begin
                    tens <= 0;
                    // Increment hundreds digit if tens digit is 9
                    if (hundreds == 4'b1001) begin
                        hundreds <= 0;
                        // Increment thousands digit if hundreds digit is 9
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
        end
    end

    // Combine the individual digits into a single 16-bit output
    always @* begin
        q = {thousands, hundreds, tens, ones};
    end

endmodule
