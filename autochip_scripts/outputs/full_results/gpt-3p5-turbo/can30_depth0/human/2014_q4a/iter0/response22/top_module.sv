module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg Q_temp; // temporary variable to store the value of Q
  
  always @(posedge clk) begin
    if (E == 1'b1) begin
      if (L == 1'b1)
        Q_temp <= R; // load new value into Q_temp
      
      else
        Q_temp <= Q; // hold the existing value of Q_temp
    end
    
    else
      Q_temp <= Q_temp >> 1; // shift Q_temp right by 1 bit
  end

  assign Q = (E == 1'b1) ? Q_temp[0] : w; // output Q_temp[0] if E is enabled, otherwise output w

endmodule
