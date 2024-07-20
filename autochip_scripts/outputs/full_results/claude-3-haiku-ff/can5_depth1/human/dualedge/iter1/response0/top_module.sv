module top_module(
    input clk,
    input d,
    output reg q
);

reg q_posedge, q_negedge;

always @(posedge clk) begin
    q_posedge <= d;
end

always @(negedge clk) begin
    q_negedge <= d;
end

always @(*) begin
    q = q_posedge | q_negedge;
end

endmodule
