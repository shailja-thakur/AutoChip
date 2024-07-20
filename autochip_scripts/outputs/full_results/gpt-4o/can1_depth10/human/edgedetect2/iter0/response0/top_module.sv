module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_d; // register to store previous state of 'in'

    always @(posedge clk) begin
        in_d <= in;              // capture previous state of 'in'
        anyedge <= (in & ~in_d); // detect 0 to 1 transition
    end
endmodule
