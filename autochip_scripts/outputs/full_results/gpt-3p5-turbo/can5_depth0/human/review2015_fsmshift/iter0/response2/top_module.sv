module top_module(
  input clk,
  input reset,
  output shift_ena);
  
  reg [3:0] count;
  reg shift_ena;

  always @(posedge clk) begin
    if (reset) begin
      count <= 4'b0000;
      shift_ena <= 1'b1;
    end else if (count == 4'b0011) begin
      count <= 4'b0000;
      shift_ena <= 1'b0;
    end else begin
      count <= count + 1'b1;
      shift_ena <= shift_ena;
    end
  end

endmodule
