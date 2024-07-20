module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg temp;
  
  always @(posedge clk) begin
    if (E) begin
      if (L) begin
        temp <= R;
      end
      else begin
        temp <= Q;
      end
    end
    else begin
      temp <= Q;
    end
  end
  
  always @(posedge clk) begin
    if (w) begin
      Q <= temp;
    end
    else begin
      Q <= 1'b0;
    end
  end
  
endmodule
