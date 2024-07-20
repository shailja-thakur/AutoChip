module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    reg [7:0] reg_value;
    
    always @(negedge clk)
    begin
        if (reset)
            reg_value <= 8'h34;
        else
            reg_value <= d;
    end
    
    assign q = reg_value;

endmodule
