module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    always @(posedge clk) begin
        for (integer i = 0; i < 8; i = i + 1) begin
            if (in[i] && !in_prev[i]) begin
                pedge[i] <= 1;
            end else begin
                pedge[i] <= 0;
            end
            in_prev[i] <= in[i];
        end
    end

    reg [7:0] in_prev;

endmodule
