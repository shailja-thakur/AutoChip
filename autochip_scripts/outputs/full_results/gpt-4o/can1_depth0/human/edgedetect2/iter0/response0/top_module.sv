module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);
    
    reg [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= (prev_in ^ in) & in; // Detect transition from 0 to 1
        prev_in <= in; // Register the current input for the next clock cycle
    end
endmodule
