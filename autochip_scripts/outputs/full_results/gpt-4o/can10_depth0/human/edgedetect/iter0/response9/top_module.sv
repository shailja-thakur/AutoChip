module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);
    
    reg [7:0] in_d;

    always @(posedge clk) begin
        in_d <= in; // Store the previous state of the input
        
        // Detect positive edge on each bit
        pedge <= (~in_d & in);
    end

endmodule
