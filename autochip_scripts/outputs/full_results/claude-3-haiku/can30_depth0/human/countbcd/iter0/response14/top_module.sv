module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the maximum value for the counter
localparam MAX_VALUE = 9999;

// Declare the individual digit values
reg [3:0] ones;
reg [3:0] tens;
reg [3:0] hundreds;
reg [3:0] thousands;

// Assign the output signal values
always @(posedge clk) begin
    if (reset) begin
        q <= 0;
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

        // Assign the output signal values
        q <= {thousands, hundreds, tens, ones};
    end
end

// Assign the enable signals
assign ena[1] = (tens != 0 || hundreds != 0 || thousands != 0);
assign ena[2] = (hundreds != 0 || thousands != 0);
assign ena[3] = (thousands != 0);

endmodule
