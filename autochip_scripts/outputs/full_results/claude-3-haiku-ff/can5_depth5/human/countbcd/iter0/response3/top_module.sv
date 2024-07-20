module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the counters for each digit
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
        if (ones == 4'd9) begin
            ones <= 0;
            ena[1] = 1; // Ones digit has rolled over, enable the tens digit
        end
        else begin
            ones <= ones + 1;
        end

        // Increment the tens digit
        if (ena[1]) begin
            if (tens == 4'd9) begin
                tens <= 0;
                ena[2] = 1; // Tens digit has rolled over, enable the hundreds digit
            end
            else begin
                tens <= tens + 1;
            end
        end

        // Increment the hundreds digit
        if (ena[2]) begin
            if (hundreds == 4'd9) begin
                hundreds <= 0;
                ena[3] = 1; // Hundreds digit has rolled over, enable the thousands digit
            end
            else begin
                hundreds <= hundreds + 1;
            end
        end

        // Increment the thousands digit
        if (ena[3]) begin
            if (thousands == 4'd9) begin
                thousands <= 0;
            end
            else begin
                thousands <= thousands + 1;
            end
        end

        // Update the output
        q = {thousands, hundreds, tens, ones};
    end
end

endmodule
