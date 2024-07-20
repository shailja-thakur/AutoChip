module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // Declare internal variables for each digit
    reg [3:0] ones, tens, hundreds, thousands;

    always @(posedge clk) begin
        if (reset) begin
            // Reset all digits to 0
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
            thousands <= 4'b0000;
        end
        else begin
            // Increment ones digit
            if (ones == 4'b1001) begin
                ones <= 4'b0000;
                // Increment tens digit when ones digit overflows
                ena[1] <= 1'b1;
            end
            else begin
                ones <= ones + 1'b1;
                ena[1] <= 1'b0;
            end

            // Increment tens digit
            if (ena[1]) begin
                if (tens == 4'b1001) begin
                    tens <= 4'b0000;
                    // Increment hundreds digit when tens digit overflows
                    ena[2] <= 1'b1;
                end
                else begin
                    tens <= tens + 1'b1;
                    ena[2] <= 1'b0;
                end
            end

            // Increment hundreds digit
            if (ena[2]) begin
                if (hundreds == 4'b1001) begin
                    hundreds <= 4'b0000;
                    // Increment thousands digit when hundreds digit overflows
                    ena[3] <= 1'b1;
                end
                else begin
                    hundreds <= hundreds + 1'b1;
                    ena[3] <= 1'b0;
                end
            end

            // Increment thousands digit
            if (ena[3]) begin
                if (thousands == 4'b1001) begin
                    thousands <= 4'b0000;
                end
                else begin
                    thousands <= thousands + 1'b1;
                end
            end
        end

        // Combine all digits into the output q
        q <= {thousands, hundreds, tens, ones};
    end

endmodule
