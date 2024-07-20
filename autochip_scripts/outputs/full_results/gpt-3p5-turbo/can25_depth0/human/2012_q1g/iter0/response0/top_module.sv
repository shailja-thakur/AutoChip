module top_module (
	input [4:1] x,
	output logic f
);

  // Define the truth table for function f
  logic [3:0] f_truth_table = 4'b1011;

  // Assign the value of f based on the input
  always_comb begin
    case (x)
      4'b0000: f = f_truth_table[0];
      4'b0001: f = f_truth_table[1];
      4'b0011: f = f_truth_table[2];
      4'b0010: f = f_truth_table[3];
      4'b0110: f = f_truth_table[4];
      4'b0111: f = f_truth_table[5];
      4'b1111: f = f_truth_table[6];
      4'b1110: f = f_truth_table[7];
      4'b1010: f = f_truth_table[8];
      4'b1011: f = f_truth_table[9];
      4'b1001: f = f_truth_table[10];
      4'b1000: f = f_truth_table[11];
      4'b1100: f = f_truth_table[12];
      4'b1101: f = f_truth_table[13];
      4'b0101: f = f_truth_table[14];
      4'b0100: f = f_truth_table[15];
      default: f = 0;
    endcase
  end

endmodule
