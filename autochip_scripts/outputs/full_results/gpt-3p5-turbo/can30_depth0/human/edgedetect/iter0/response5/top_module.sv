module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in;
    pedge <= 8'b0;
    for (integer i = 0; i < 8; i = i + 1) begin
        if (in_prev[i] == 1'b0 && in[i] == 1'b1) begin
            pedge[i] <= 1'b1;
        end
    end
end

endmodule
