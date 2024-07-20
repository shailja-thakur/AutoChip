module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in;
    
    pedge[0] <= (in[0] == 1'b1) && (in_prev[0] == 1'b0);
    pedge[1] <= (in[1] == 1'b1) && (in_prev[1] == 1'b0);
    pedge[2] <= (in[2] == 1'b1) && (in_prev[2] == 1'b0);
    pedge[3] <= (in[3] == 1'b1) && (in_prev[3] == 1'b0);
    pedge[4] <= (in[4] == 1'b1) && (in_prev[4] == 1'b0);
    pedge[5] <= (in[5] == 1'b1) && (in_prev[5] == 1'b0);
    pedge[6] <= (in[6] == 1'b1) && (in_prev[6] == 1'b0);
    pedge[7] <= (in[7] == 1'b1) && (in_prev[7] == 1'b0);
end

endmodule
