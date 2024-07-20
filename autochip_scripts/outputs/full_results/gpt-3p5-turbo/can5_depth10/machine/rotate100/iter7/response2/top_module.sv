module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [1:0] ena_reg;
  reg q_reg [99:0];

  always @(posedge clk) begin
    ena_reg <= ena;
    
    if (load) begin
      q_reg <= data;
    end else if (ena_reg == 2'b01) begin
      q_reg <= {q_reg[98:0], q_reg[99]};
    end else if (ena_reg == 2'b10) begin
      q_reg <= {q_reg[0], q_reg[99:1]};
    end
  end

  always @(posedge clk) begin
    q <= q_reg;
  end

endmodule
