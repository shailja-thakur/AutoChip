module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

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
            ena[1] = 1; // Tens digit should be incremented
        end
        else begin
            ones <= ones + 1;
            ena[1] = 0;
        end

        // Increment the tens digit
        if (ena[1]) begin
            if (tens == 9) begin
                tens <= 0;
                ena[2] = 1; // Hundreds digit should be incremented
            end
            else begin
                tens <= tens + 1;
                ena[2] = 0;
            end
        end

        // Increment the hundreds digit
        if (ena[2]) begin
            if (hundreds == 9) begin
                hundreds <= 0;
                ena[3] = 1; // Thousands digit should be incremented
            end
            else begin
                hundreds <= hundreds + 1;
                ena[3] = 0;
            end
        end

        // Increment the thousands digit
        if (ena[3]) begin
            if (thousands == 9) begin
                thousands <= 0;
            end
            else begin
                thousands <= thousands + 1;
            end
        end

        // Update the output
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
