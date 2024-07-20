module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
  if (x == 4'b0000 || x == 4'b0011 || x == 4'b0101 || x == 4'b1000 || x == 4'b1010)
    f = 1'b1;
  else
    f = 1'b0;
end

endmodule
