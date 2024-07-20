module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    // Internal signals
    reg [3:0] ones_digit;
    reg [3:0] tens_digit;
    reg [3:0] hundreds_digit;
    reg [3:0] thousands_digit;

    // Synchronous counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ones_digit <= 0;
            tens_digit <= 0;
            hundreds_digit <= 0;
            thousands_digit <= 0;
        end else begin
            if (ena[1]) begin
                ones_digit <= ones_digit + 1;
                if (ones_digit == 9) begin
                    tens_digit <= tens_digit + 1;
                    ones_digit <= 0;
                    if (tens_digit == 9) begin
                        hundreds_digit <= hundreds_digit + 1;
                        tens_digit <= 0;
                        if (hundreds_digit == 9) begin
                            thousands_digit <= thousands_digit + 1;
                            hundreds_digit <= 0;
                        end
                    end
                end
            end
        end
    end

    // Assign outputs
    assign q[3:0] = ones_digit;
    assign q[7:4] = tens_digit;
    assign q[11:8] = hundreds_digit;
    assign q[15:12] = thousands_digit;

endmodule
