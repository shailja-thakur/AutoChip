module top_module (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
  
  always @(*) begin
    left = (scancode == 16'he06b) ? 1'b1 : 1'b0;
    down = (scancode == 16'he072) ? 1'b1 : 1'b0;
    right = (scancode == 16'he074) ? 1'b1 : 1'b0;
    up = (scancode == 16'he075) ? 1'b1 : 1'b0;
  end
  
endmodule
