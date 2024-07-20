module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] last_in;

    always @(posedge clk) begin
        last_in <= in;
        anyedge <= 0;
        for (integer i = 0; i < 8; i = i + 1) begin
            if (in[i] != last_in[i]) begin
                anyedge[i] <= 1;
            end
        end
    end

endmodule
