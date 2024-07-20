module top_module (
    input wire clk,
    input wire a,
    input wire b,
    output wire q,
    output reg state
);

reg [1:0] q_reg;
reg [1:0] state_reg;

always @(posedge clk) begin
    q_reg <= {q_reg[0], a & b};
    state_reg <= {state_reg[0], (a & b) ? 1'b1 : 1'b0};
end

assign q = q_reg[1];
assign state = state_reg[1];

endmodule
