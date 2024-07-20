module top_module (
  input wire clk,
  input wire w,
  input wire R,
  input wire E,
  input wire L,
  output reg Q
);
  reg D;
  
  always @(posedge clk) begin
    if (L) begin
      Q <= R;
    end else if (E) begin
      Q <= D;
    end
  end
  
  always @(posedge clk) begin
    if (E) begin
      D <= w;
    end
  end
endmodule
