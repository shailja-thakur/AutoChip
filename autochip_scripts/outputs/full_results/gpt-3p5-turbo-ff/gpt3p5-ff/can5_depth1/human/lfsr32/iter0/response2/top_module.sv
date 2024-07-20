module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

  reg [31:0] q_reg;

  always @(posedge clk or posedge reset) begin
        if (reset)
            q_reg <= 32'b1;
        else begin
            q_reg[0] <= q_reg[31] ^ q_reg[21] ^ q_reg[1] ^ q_reg[0];
            q_reg[31:1] <= q_reg[30:0];
        end
  end

  assign q = q_reg;

endmodule
