module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
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
        end else if (ena[3]) begin
            ones_digit <= ones_digit + 1;
            if (ones_digit == 4'b1010) begin
                ones_digit <= 4'b0000;
                tens_digit <= tens_digit + 1;
                
                if (tens_digit == 4'b1010) begin
                    tens_digit <= 4'b0000;
                    hundreds_digit <= hundreds_digit + 1;
                    
                    if (hundreds_digit == 4'b1010) begin
                        hundreds_digit <= 4'b0000;
                        thousands_digit <= thousands_digit + 1;
                        
                        if (thousands_digit == 4'b1010) begin
                            thousands_digit <= 4'b0000;
                        end
                    end
                end
            end
        end else begin
            ones_digit <= ones_digit;
            tens_digit <= tens_digit;
            hundreds_digit <= hundreds_digit;
            thousands_digit <= thousands_digit;
        end
    end
    
    assign ena = {thousands_digit[3], hundreds_digit[3], tens_digit[3]};
    assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
    
endmodule
