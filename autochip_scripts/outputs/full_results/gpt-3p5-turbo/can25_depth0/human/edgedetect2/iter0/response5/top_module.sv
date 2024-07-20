module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        in_prev <= in;
        anyedge <= 0;

        for (int i = 0; i < 8; i = i + 1) begin
            if (in_prev[i] == 0 && in[i] == 1) begin
                anyedge[i] <= 1;
            end
        end
    end

endmodule
