module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] previous;

always @(posedge clk) begin
    for (int i = 0; i < 8; i = i + 1) begin
        if (in[i] && !previous[i]) begin
            anyedge[i] <= 1;
        end else begin
            anyedge[i] <= 0;
        end
        previous[i] <= in[i];
    end
end

endmodule
