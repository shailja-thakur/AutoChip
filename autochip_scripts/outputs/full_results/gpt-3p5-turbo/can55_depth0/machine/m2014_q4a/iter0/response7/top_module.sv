module top_module (
  input d,
  input ena,
  output logic q
);
  
  always_comb begin
    if(ena == 1'b1) begin
      q = d;
    end else begin
      q = q;
    end
  end
  
endmodule
