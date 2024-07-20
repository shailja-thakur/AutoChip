module top_module (
	input in1,
	input in2,
	output logic out
);
  
  always_comb begin
    if (in1 == 1'b1 && in2 == 1'b0) begin
      out = 1'b1;
    end else begin
      out = 1'b0;
    end
  end
  
endmodule
