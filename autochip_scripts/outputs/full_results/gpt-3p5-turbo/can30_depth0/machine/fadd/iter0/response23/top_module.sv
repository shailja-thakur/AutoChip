module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

  // Internal wire to store the intermediate result of the addition
  wire [1:0] temp_sum;

  // Internal wire to store the carry-out bit
  wire temp_cout;

  // Assign the sum and carry-out bits based on the inputs
  assign {temp_cout, temp_sum} = a + b + cin;

  // Calculate the sum output by taking the modulo 2 of the temp_sum
  assign sum = temp_sum[0];

  // Set the carry-out bit based on the value of temp_sum[1]
  assign cout = (temp_sum[1] >= 2) ? 1'b1 : 1'b0;

endmodule
