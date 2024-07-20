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
        q <= 16'b0000;
    else if (ena[1])
        begin
            if (ones_digit == 9)
                ones_digit <= 4'b0000;
            else
                ones_digit <= ones_digit + 1;
        end
    
    if (reset)
        ena <= 3'b000;
    else
        ena <= 3'b111;
    
    q[3:0] <= ones_digit;
    q[7:4] <= tens_digit;
    q[11:8] <= hundreds_digit;
    q[15:12] <= thousands_digit;
end

endmodule
