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
        if (ones == 4'd9) begin
            ones <= 0;
            ena[1] = 1'b1;
        end
        else begin
            ones <= ones + 1'b1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (ones == 4'd9 && ena[1]) begin
            if (tens == 4'd9) begin
                tens <= 0;
                ena[2] = 1'b1;
            end
            else begin
                tens <= tens + 1'b1;
                ena[2] = 1'b0;
            end
        end

        // Increment the hundreds digit
        if (ones == 4'd9 && tens == 4'd9 && ena[2]) begin
            if (hundreds == 4'd9) begin
                hundreds <= 0;
                ena[3] = 1'b1;
            end
            else begin
                hundreds <= hundreds + 1'b1;
                ena[3] = 1'b0;
            end
        end

        // Increment the thousands digit
        if (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9 && ena[3]) begin
            if (thousands == 4'd9) begin
                thousands <= 0;
            end
            else begin
                thousands <= thousands + 1'b1;
            end
        end

        // Combine the digits into the 16-bit output
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
