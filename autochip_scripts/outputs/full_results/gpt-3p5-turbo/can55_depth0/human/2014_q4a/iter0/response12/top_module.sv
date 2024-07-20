module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg Q_temp;
  
  always @(posedge clk) begin
    if (E) begin
      if (L) begin
        Q_temp <= R;
      end else begin
        Q_temp <= Q;
      end
    end else begin
      Q_temp <= Q;
    end
  end
  
  always @(posedge clk) begin
    if (E) begin
      Q <= Q_temp;
    end
  end
  
  always @(posedge clk) begin
    if (E) begin
      if (L) begin
        Q <= R;
      end else begin
        Q <= Q_temp;
      end
    else begin
      Q <= Q_temp;
    end
  end
  
endmodule
