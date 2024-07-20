module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev_bit;

    always @(posedge clk) begin
        for (int i = 0; i < 8; i = i + 1) begin
            if (prev_bit[i] == 1'b0 && in[i] == 1'b1)
                pedge[i] <= 1'b1;
            else
                pedge[i] <= 1'b0;
            prev_bit[i] <= in[i];
        end
    end

endmodule
