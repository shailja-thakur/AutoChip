module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  reg q;
  
  always @* begin
    if (a == 1'b1) begin
      if (b == 1'b0) begin
        if (c == 1'b0) begin
          if (d == 1'b0)
            q = 1'b1;
          else
            q = 1'b0;
        end else begin
          if (d == 1'b1)
            q = 1'b1;
          else
            q = 1'b0;
        end
      end else begin
        if (c == 1'b1) begin
          if (d == 1'b0)
            q = 1'b1;
          else
            q = 1'b0;
        end else begin
          if (d == 1'b1)
            q = 1'b1;
          else
            q = 1'b0;
        end
      end
    end else begin
      q = 1'b0;
    end
  end
  
endmodule
