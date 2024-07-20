module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk or posedge reset) begin
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
            // Increment tens digit when ones rolls over
            if (tens == 4'd9) begin
                tens <= 0;
                // Increment hundreds digit when tens rolls over
                if (hundreds == 4'd9) begin
                    hundreds <= 0;
                    // Increment thousands digit when hundreds rolls over
                    if (thousands == 4'd9) begin
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

        // Assign output
        q <= {thousands, hundreds, tens, ones};
    end
end

// Enable signals for higher digits
assign ena[1] = (ones == 4'd9);
assign ena[2] = (tens == 4'd9);
assign ena[3] = (hundreds == 4'd9);

endmodule
