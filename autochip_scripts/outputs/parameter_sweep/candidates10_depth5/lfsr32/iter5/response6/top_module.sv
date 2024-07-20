module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;
  reg [31:0] q_reg; // Add a register to store the current state of q

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q_reg <= 32'h1;
      q <= q_reg; // Assign the value of q_reg to q on reset
    end else begin
      next_q = {q_reg[30:0], q_reg[0] ^ q_reg[20] ^ q_reg[1] ^ q_reg[31]};
      q_reg <= next_q; // Assign the value of next_q to q_reg
      q <= q_reg; // Assign the value of q_reg to q
    end
  end

endmodule
