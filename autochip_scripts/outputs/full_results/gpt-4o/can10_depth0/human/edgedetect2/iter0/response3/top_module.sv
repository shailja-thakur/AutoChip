module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);
    
    reg [7:0] in_d; // 8-bit register to store the previous state of 'in'
    
    always @(posedge clk) begin
        in_d <= in; // Store the current state of 'in' to in_d
        anyedge <= (in ^ in_d) & in; // Detect any edge and set output bit after 0 to 1 transition
    end
    
endmodule
