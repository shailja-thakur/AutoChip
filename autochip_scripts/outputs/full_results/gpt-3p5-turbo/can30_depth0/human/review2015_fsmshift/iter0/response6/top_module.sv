module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] count;
  reg shift_ena;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 0;
      shift_ena <= 1;
    end else begin
      if (count < 4) begin
        count <= count + 1;
        shift_ena <= 1;
      end else begin
        count <= 0;
        shift_ena <= 0;
      end
    end
  end

endmodule
