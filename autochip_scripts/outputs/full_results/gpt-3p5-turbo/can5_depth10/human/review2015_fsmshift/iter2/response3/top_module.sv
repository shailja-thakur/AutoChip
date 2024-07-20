module top_module(
  input clk,
  input reset,
  output reg shift_ena
);

reg [2:0] count;
reg reset_triggered;

always @(posedge clk or posedge reset) begin
  if (reset || reset_triggered) begin
    count <= 3'b0;
    shift_ena <= 1'b1;
    reset_triggered <= 1'b1;
  end else begin
    count <= count + 1'b1;
    if (count < 3'b100) begin
      shift_ena <= 1'b1;
    end else begin
      shift_ena <= 1'b0;
    end
  end
end

always @(posedge clk) begin
  if (reset) begin
    reset_triggered <= 1'b0;
  end
end

endmodule
