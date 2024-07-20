module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  reg [31:0] num;
  reg [31:0] comp_num;
  reg [31:0] z_reg;
  reg convert;
  reg reset_done;

  always @(posedge clk or posedge areset) begin
    if (areset)
      num <= 0;
    else if (!reset_done)
      num <= num + x;

    if (!areset)
      convert <= 1;
    else if (!reset_done) begin
      convert <= 0;
      reset_done <= 1;
    end

    if (convert)
      z_reg <= ~num + 1;

    if (areset)
      comp_num <= 0;
    else if (!reset_done)
      comp_num <= comp_num + x;

    if (convert)
      z <= z_reg[0];
  end

endmodule
