module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] previous_state;

    always @(posedge clk) begin
        anyedge <= (previous_state ^ in) & ~previous_state & in;
        previous_state <= in;
    end
endmodule
