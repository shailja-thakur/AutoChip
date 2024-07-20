module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [31:0] sum;
  reg [32:0] twos_complement;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      sum <= 0;
      twos_complement <= 0;
      z <= 0;
    end else begin
      sum <= sum + x;
      
      // Calculate 2's complement of sum
      if (x == 1'b1) begin
        twos_complement <= (~sum) + 1;
      end else begin
        twos_complement <= ~sum;
      end
      
      // Assign output z
      z <= twos_complement[31:0];
    end
  end
endmodule
