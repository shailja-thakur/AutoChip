module top_module (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
  always @(*) begin
    left = (scancode == 16'h0e06b) ? 1 : 0;
    down = (scancode == 16'h0e072) ? 1 : 0;
    right = (scancode == 16'h0e074) ? 1 : 0;
    up = (scancode == 16'h0e075) ? 1 : 0;
  end
endmodule
