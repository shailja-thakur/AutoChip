module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  always @(*) begin
    // Karnaugh map cell values
    if (c == 0 && d == 0) begin
      if (a == 0 && b == 0) out = 0;
      else if (a == 0 && b == 1) out = 1;
      else if (a == 1 && b == 0) out = 1;
      else if (a == 1 && b == 1) out = 1;
    end
    else if (c == 0 && d == 1) begin
      if (a == 0 && b == 0) out = d;
      else if (a == 0 && b == 1) out = d;
      else if (a == 1 && b == 0) out = d;
      else if (a == 1 && b == 1) out = d;
    end
    else if (c == 1 && d == 0) begin
      if (a == 0 && b == 0) out = 1;
      else if (a == 0 && b == 1) out = d;
      else if (a == 1 && b == 0) out = 1;
      else if (a == 1 && b == 1) out = 1;
    end
    else if (c == 1 && d == 1) begin
      if (a == 0 && b == 0) out = 1;
      else if (a == 0 && b == 1) out = 1;
      else if (a == 1 && b == 0) out = 1;
      else if (a == 1 && b == 1) out = 1;
    end
  end

endmodule
