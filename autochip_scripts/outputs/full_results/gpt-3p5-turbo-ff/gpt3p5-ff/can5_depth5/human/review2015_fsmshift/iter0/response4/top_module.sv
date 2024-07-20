module top_module (
  input clk,
  input reset,
  output reg shift_ena
);

  reg [3:0] counter;
  reg detect_pattern;
  
  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
      shift_ena <= 1;
      detect_pattern <= 0;
    end else begin
      counter <= counter + 1;
      detect_pattern <= (counter == 0) ? 1'b1 : (detect_pattern & (counter < 4));
      shift_ena <= detect_pattern;
    end
  end
  
endmodule
