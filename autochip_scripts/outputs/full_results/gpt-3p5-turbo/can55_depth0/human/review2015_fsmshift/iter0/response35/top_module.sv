module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] count;

  always @(posedge clk) begin
    if (reset) begin
      shift_ena <= 1;
      count <= 0;
    end else if (count == 4) begin
      shift_ena <= 0;
    end else if (shift_ena) begin
      count <= count + 1;
    end
  end
  
endmodule
