module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;
        anyedge <= 0;
        for (integer i = 0; i < 8; i = i + 1) begin
            anyedge[i] <= (in[i] == 1 && prev_in[i] == 0);
        end
    end
endmodule
