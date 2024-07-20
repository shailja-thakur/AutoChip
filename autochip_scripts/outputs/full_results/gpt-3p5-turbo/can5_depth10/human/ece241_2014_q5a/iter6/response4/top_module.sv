module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

reg [31:0] x_reg;
reg [31:0] z_reg;
reg x_reg_updated;

always @(posedge clk or negedge areset) begin
  if (areset == 0) begin
    x_reg <= 0;
    z_reg <= 0;
  end else begin
    x_reg <= {x_reg[30:0], x};
    if (x_reg_updated) begin
      z_reg <= (~x_reg + 1);
    end
 	end
  x_reg_updated <= (areset != 1);
end

assign z = z_reg[31];

endmodule
