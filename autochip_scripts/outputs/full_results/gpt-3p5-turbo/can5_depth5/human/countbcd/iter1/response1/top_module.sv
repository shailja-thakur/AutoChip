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
    if (reset)
        q <= 0;
    else begin
        if (ena[1]) begin
            ones_digit <= ones_digit + 4'b1;
            if (ones_digit == 10) begin
                ones_digit <= 0;
                tens_digit <= tens_digit + 4'b1;
                if (tens_digit == 10) begin
                    tens_digit <= 0;
                    hundreds_digit <= hundreds_digit + 4'b1;
                    if (hundreds_digit == 10) begin
                        hundreds_digit <= 0;
                        thousands_digit <= thousands_digit + 4'b1;
                        
                    end
                end
            end
        end
    end
end
 
assign ena = {hundreds_digit, tens_digit, ones_digit};
assign q = {thousands_digit, hundreds_digit, tens_digit, ones_digit};
 
endmodule
