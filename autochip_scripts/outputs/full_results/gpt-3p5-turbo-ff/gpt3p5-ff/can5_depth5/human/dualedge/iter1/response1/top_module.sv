module top_module(
  input clk,
  input d,
  output reg q);

  reg q_reg;

  always @(posedge clk) begin
    q_reg <= d;
  end

  always @(negedge clk) begin
    q_reg <= d;
  end

  always @(posedge clk or negedge clk) begin
    q <= q_reg;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
  end
  
endmodule
