module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;
    
    always @(posedge clk) begin
        anyedge <= (in & ~prev_in);  // Detecting 0 to 1 transitions
        prev_in <= in;               // Storing previous state of 'in'
    end
endmodule
