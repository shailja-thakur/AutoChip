module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [3:0] counter;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 4'd0;
      shift_ena <= 1'b1;
    end else begin
      if (counter < 4'd3) begin
        counter <= counter + 1;
        shift_ena <= 1'b1;
      end else begin
        counter <= 4'd0;
        shift_ena <= 1'b0;
      end
    end
  end

endmodule
