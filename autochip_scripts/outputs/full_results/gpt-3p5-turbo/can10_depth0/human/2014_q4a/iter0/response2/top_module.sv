module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
  
  reg [1:0] MUX_sel;
  wire MUX_out;
  wire D;
  
  assign D = (E && L) ? R : MUX_out;
  
  always @(posedge clk) begin
    if (E) begin
      MUX_sel <= MUX_sel + 1;
    end
    else if (L) begin
      MUX_sel <= 2'b0;
    end
  end
  
  assign MUX_out = (MUX_sel == 2'b00) ? w :
                  (MUX_se1 == 2'b01) ? Q :
                  (MUX_sel == 2'b10) ? w :
                  (MUX_se1 == 2'b11) ? D :
                  1'bz;
  
  always @(posedge clk) begin
    if (E) begin
      Q <= MUX_out;
    end
  end
endmodule
