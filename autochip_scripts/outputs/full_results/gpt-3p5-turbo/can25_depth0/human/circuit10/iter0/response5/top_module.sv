module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q_reg;
wire state_wire;

always @(posedge clk) begin
    q_reg <= (a & ~b) | (b & ~a);
end

assign q = q_reg;
assign state = state_wire;

endmodule
