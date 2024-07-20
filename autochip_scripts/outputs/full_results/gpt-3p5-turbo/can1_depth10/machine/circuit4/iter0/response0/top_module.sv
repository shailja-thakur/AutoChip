module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
  // We will use a wire to perform the OR operation between b and c
  wire q_wire;
  // Perform the OR operation
  assign q_wire = b | c;
  // The output q is driven by q_wire
  assign q = q_wire;
endmodule
