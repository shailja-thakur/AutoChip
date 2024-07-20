module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  reg q;

  always @(*) begin
    if (a & ~b & c & ~d) begin
      q = 1;
    end
    else begin
      q = 0;
    end
  end

endmodule
