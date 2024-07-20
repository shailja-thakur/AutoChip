module top_module(
  input clk,
  input load,
  input [511:0] data,
  output [511:0] q);

  reg [511:0] q_reg;

  always @(posedge clk) begin
    if (load) begin
      q_reg <= data;
    end else begin
      q_reg[0]         <= q_reg[511] ^ q_reg[0] ^ q_reg[1];
      q_reg[511]       <= q_reg[510] ^ q_reg[511] ^ 1'b0;
      q_reg[1:510]     <= q_reg[0:509] ^ q_reg[1:510] ^ q_reg[2:511];
    end
  end

  assign q = q_reg;

endmodule
