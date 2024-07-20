module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_d;
    
    always @(posedge clk) begin
        in_d <= in;                        // Register the input
        anyedge <= in & ~in_d;             // Detect the rising edge
    end

endmodule
