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
        // Increment ones digit
        if (ones == 4'd9) begin
            ones <= 0;
            ena[1] = 1'b1;
        end
        else begin
            ones <= ones + 1;
            ena[1] = 1'b0;
        end

        // Increment tens digit
        if (ones == 4'd9 && tens == 4'd9) begin
            tens <= 0;
            ena[2] = 1'b1;
        end
        else if (ones == 4'd9) begin
            tens <= tens + 1;
            ena[2] = 1'b0;
        end

        // Increment hundreds digit
        if (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9) begin
            hundreds <= 0;
            ena[3] = 1'b1;
        end
        else if (ones == 4'd9 && tens == 4'd9) begin
            hundreds <= hundreds + 1;
            ena[3] = 1'b0;
        end

        // Increment thousands digit
        if (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9 && thousands == 4'd9) begin
            thousands <= 0;
        end
        else if (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9) begin
            thousands <= thousands + 1;
        end

        // Assemble the output
        q[3:0] <= ones;
        q[7:4] <= tens;
        q[11:8] <= hundreds;
        q[15:12] <= thousands;
    end
end

endmodule
