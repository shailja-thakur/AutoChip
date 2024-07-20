module top_module (
  input clk,
  input d,
  input r,
  output logic q
);
  
  always_ff @(posedge clk or posedge r) begin
    if (r) begin
      q <= 0;
    end else begin
      q <= d;
    end
  end
    
endmodule
