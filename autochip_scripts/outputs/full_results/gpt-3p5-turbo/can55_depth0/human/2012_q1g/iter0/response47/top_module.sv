module top_module (
	input [4:1] x,
	output logic f
);

  // First we need to define the truth table for the function f
  // We will use the given Karnaugh map to determine the output for each input combination

  // Define the output for each input combination
  // 00 | 1 | 0 | 0 | 1 |
  // 01 | 0 | 0 | 0 | 0 |
  // 11 | 1 | 1 | 1 | 0 |
  // 10 | 1 | 1 | 0 | 1 |
  logic [15:0] truth_table = 16'b1000100000001101;
 
  /* Uncomment this code for simulation purposes
  always_comb begin
    f = truth_table[x];
  end
  */
endmodule
