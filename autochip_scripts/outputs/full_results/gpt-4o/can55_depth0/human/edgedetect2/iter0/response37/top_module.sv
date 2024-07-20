module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] previous_in;

    always @(posedge clk) begin
        anyedge <= in & ~previous_in;
        previous_in <= in;
    end
endmodule
