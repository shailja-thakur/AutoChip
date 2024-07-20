module top_module( input clk, input d, output reg q);

reg q_reg1;
reg q_reg2;

always @(posedge clk) begin
    q_reg1 <= d;
end

always @(negedge clk) begin
    q_reg2 <= q_reg1;
    q <= q_reg2;
end

endmodule
