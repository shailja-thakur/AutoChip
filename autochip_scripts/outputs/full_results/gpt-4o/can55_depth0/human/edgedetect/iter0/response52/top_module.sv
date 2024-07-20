module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d;

    always @(posedge clk) begin
        for (int i = 0; i < 8; i = i + 1) begin
            pedge[i] <= ~in_d[i] & in[i];
        end
        in_d <= in;
    end

endmodule
