module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // register to store the delayed version of input

    always @(posedge clk) begin
        in_d <= in; // update the delayed version of input
        pedge <= (in & ~in_d); // detect positive edges
    end

endmodule
