module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    reg [31:0] in_d; // register to hold the previous value of in
    
    always @(posedge clk) begin
        if (reset) begin
            in_d <= 32'b0;
            out <= 32'b0;
        end else begin
            in_d <= in;
            // Capture falling edge from 1 to 0
            out <= out | (in_d & ~in);
        end
    end
endmodule
