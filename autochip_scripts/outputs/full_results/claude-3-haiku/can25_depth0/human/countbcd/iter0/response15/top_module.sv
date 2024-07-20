module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

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
            ena[1] = 1'b1;
        end
        else begin
            ones <= ones + 1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (ones == 9 && tens == 9) begin
            tens <= 0;
            ena[2] = 1'b1;
        end
        else if (ones == 9) begin
            tens <= tens + 1;
            ena[2] = 1'b1;
        end
        else begin
            ena[2] = 1'b0;
        end

        // Increment the hundreds digit
        if (ones == 9 && tens == 9 && hundreds == 9) begin
            hundreds <= 0;
            ena[3] = 1'b1;
        end
        else if (ones == 9 && tens == 9) begin
            hundreds <= hundreds + 1;
            ena[3] = 1'b1;
        end
        else begin
            ena[3] = 1'b0;
        end

        // Update the output
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
