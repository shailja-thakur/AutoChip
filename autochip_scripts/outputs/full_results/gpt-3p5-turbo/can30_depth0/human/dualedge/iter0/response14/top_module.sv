module top_module (
    input clk,
    input d,
    output reg q,
    output reg qbar
);

reg q_ff1;
reg q_ff2;

always @(posedge clk) begin
    q_ff1 <= d;
    q_ff2 <= q_ff1;
end

always @(negedge clk) begin
    q_ff2 <= q_ff1;
end

assign q = q_ff2;
assign qbar = ~q_ff2;

endmodule
