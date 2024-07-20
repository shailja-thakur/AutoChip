module top_module(
  input clk,
  input reset,
  output reg shift_ena // fix 1: change wire to reg
);

reg [3:0] count;
reg shift_ena_reg;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    count <= 4'b0;
    shift_ena_reg <= 1'b1;
  end else begin
    count <= count + 1'b1;
    if (count < 4'b1000) begin
      shift_ena_reg <= 1'b1;
    end else begin
      shift_ena_reg <= 1'b0;
    end
  end
end

assign shift_ena = shift_ena_reg;

endmodule
