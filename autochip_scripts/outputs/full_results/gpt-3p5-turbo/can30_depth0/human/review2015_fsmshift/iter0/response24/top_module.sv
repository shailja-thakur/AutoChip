module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] counter;
  reg shift_ena;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 4'b0;
      shift_ena <= 1'b1;
    end else begin
      if (counter == 4'b1111) begin
        counter <= 4'b0;
        shift_ena <= 1'b0;
      end else begin
        counter <= counter + 1'b1;
        shift_ena <= shift_ena;
      end
    end
  end
endmodule
