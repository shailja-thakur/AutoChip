module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

  always @(*) begin
    if (c == 0) begin
      if (d == 0) begin
        if (a == 0 && b == 1) out = 0;
        else if (a == 1 && b == 0) out = 1;
        else out = 1;
      end
      else if (d == 1) begin
        if (a == 0 && b == 0) out = d;
        else if (a == 0 && b == 1) out = 0;
        else if (a == 1 && b == 0) out = d;
        else if (a == 1 && b == 1) out = d;
      end
    end
    else if (c == 1) begin
      out = 1;
    end
  end

endmodule
