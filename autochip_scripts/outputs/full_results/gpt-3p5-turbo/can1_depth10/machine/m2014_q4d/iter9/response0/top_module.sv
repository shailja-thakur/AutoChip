module top_module (
  input clk,
  input in,
  output reg out
);

  always @(posedge clk) begin
    out <= in ^ out;
  end
  
  initial begin
    out = 1'b0;
    #10; in = 1'b0;
    #10; in = 1'b1;
    #10; in = 1'b0;
    #10; in = 1'b1;
    #10; in = 1'b0;
    #10; $finish;
  end

endmodule
