module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Declare the variables for the individual digits
reg [3:0] ones;
reg [3:0] tens;
reg [3:0] hundreds;
reg [3:0] thousands;

always @(posedge clk) begin
    if (reset) begin
        // Reset all the digits to 0
        ones <= 4'b0000;
        tens <= 4'b0000;
        hundreds <= 4'b0000;
        thousands <= 4'b0000;
    end
    else begin
        // Increment the ones digit
        if (ones == 4'b1001) begin
            ones <= 4'b0000;
            // Increment the tens digit
            if (tens == 4'b1001) begin
                tens <= 4'b0000;
                // Increment the hundreds digit
                if (hundreds == 4'b1001) begin
                    hundreds <= 4'b0000;
                    // Increment the thousands digit
                    if (thousands == 4'b1001) begin
                        thousands <= 4'b0000;
                    end
                    else begin
                        thousands <= thousands + 4'b0001;
                    end
                end
                else begin
                    hundreds <= hundreds + 4'b0001;
                end
            end
            else begin
                tens <= tens + 4'b0001;
            end
        end
        else begin
            ones <= ones + 4'b0001;
        end
    end
end

// Assign the output signals
assign q = {thousands, hundreds, tens, ones};
assign ena[1] = (tens != 4'b1001) || (hundreds != 4'b1001) || (thousands != 4'b1001);
assign ena[2] = (hundreds != 4'b1001) || (thousands != 4'b1001);
assign ena[3] = (thousands != 4'b1001);

endmodule
