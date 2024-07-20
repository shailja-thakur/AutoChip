module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in;
end

always @(posedge clk) begin
    for (int i=0; i<8; i=i+1) begin
        if (in_prev[i] == 0 && in[i] == 1) begin
            pedge[i] <= 1;
        end else begin
            pedge[i] <= 0;
        end
    end
end

endmodule
