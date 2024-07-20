module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

reg [31:0] next_q;
reg [31:0] q_reg;

always @(posedge clk) begin
    if (reset)
        q_reg <= 32'h1;
    else
        q_reg <= next_q;
end

always @* begin
    next_q[0] = q_reg[31] ^ q_reg[21] ^ q_reg[1] ^ q_reg[0];
    for (int i = 1; i < 32; i = i + 1) begin
        next_q[i] = q_reg[i-1];
    end
end

assign q = q_reg;

endmodule
