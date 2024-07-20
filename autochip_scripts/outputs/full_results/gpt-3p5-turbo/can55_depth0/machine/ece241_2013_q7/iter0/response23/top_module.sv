module top_module (
  input clk,
  input j,
  input k,
  output reg Q
);

  always @(posedge clk) begin
    if(j && ~Q) begin
      Q <= j;
    end else begin
      Q <= (~k) | Q;
    end
  end

endmodule
