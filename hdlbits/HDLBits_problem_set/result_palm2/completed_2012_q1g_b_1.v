module top_module (
    input [4:1] x,
    output f
); 

  always @(x or f) begin
    if (x[1] & x[2]) begin
      f <= 1;
    end else if (~x[1] & ~x[2]) begin
      if (x[3] & x[4]) begin
        f <= 1;
      end
    end
  end

endmodule