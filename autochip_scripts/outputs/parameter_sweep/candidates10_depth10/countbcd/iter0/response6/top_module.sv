module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    reg [3:0] ones_digit;
    reg [3:0] tens_digit;
    reg [3:0] hundreds_digit;
    reg [3:0] thousands_digit;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ones_digit <= 4'b0000;
            tens_digit <= 4'b0000;
            hundreds_digit <= 4'b0000;
            thousands_digit <= 4'b0000;
        end else begin
            if (ena[1]) begin
                if (ones_digit == 4'b1001) begin
                    ones_digit <= 4'b0000;
                    tens_digit <= tens_digit + 4'b0001;
                end else begin
                    ones_digit <= ones_digit + 4'b0001;
                end
            end
            if (ena[2]) begin
                if (tens_digit == 4'b1001) begin
                    tens_digit <= 4'b0000;
                    hundreds_digit <= hundreds_digit + 4'b0001;
                end else begin
                    tens_digit <= tens_digit + 4'b0001;
                end
            end
            if (ena[3]) begin
                if (hundreds_digit == 4'b1001) begin
                    hundreds_digit <= 4'b0000;
                    thousands_digit <= thousands_digit + 4'b0001;
                end else begin
                    hundreds_digit <= hundreds_digit + 4'b0001;
                end
            end
        end
    end
    
    assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};

endmodule
