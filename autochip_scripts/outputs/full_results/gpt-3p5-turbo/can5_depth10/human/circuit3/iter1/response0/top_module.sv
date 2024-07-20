module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);

  always @* begin
    if (~a & ~b & ~c & ~d) begin
      q = 0;
    end else if (~a & ~b & ~c & d) begin
      q = 0;
    end else if (~a & ~b & c & ~d) begin
      q = 0;
    end else if (~a & b & ~c & d) begin
      q = 0;
    end else if (a & ~b & ~c & d) begin
      q = 0;
    end else if (a & ~b & c & d) begin
      q = 0;
    end else if (a & b & c & d) begin
      q = 1;
    end else begin
      q = 1;
    end
  end

endmodule
