module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);
    
reg [7:0] q_reg [0:7];
    
always @(posedge clk) begin
    q_reg[0] <= d[0];
    q_reg[1] <= d[1];
    q_reg[2] <= d[2];
    q_reg[3] <= d[3];
    q_reg[4] <= d[4];
    q_reg[5] <= d[5];
    q_reg[6] <= d[6];
    q_reg[7] <= d[7];
end

assign q = q_reg;

endmodule
