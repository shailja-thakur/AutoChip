module top_module (
  input [4:1] x,
  output logic f
);

  // 2. Create intermediate signals to represent the combinations of inputs. 
  //    These signals will be used in the logic equations.
  wire w1, w2, w3, w4, w5, w6, w7, w8;

  // 3. Assign the intermediate signals based on the input combinations.
  assign w1 = x[1] & x[2];
  assign w2 = x[3] & x[4];
  assign w3 = ~x[1] & ~x[2] & ~x[3] & x[4];
  assign w4 = ~x[1] & ~x[2] & x[3] & x[4];
  assign w5 = x[1] & ~x[2] & ~x[3] & ~x[4];
  assign w6 = x[1] & ~x[2] & x[3] & ~x[4];
  assign w7 = ~x[1] & x[2] & ~x[3] & x[4];
  assign w8 = ~x[1] & x[2] & x[3] & ~x[4];

  // 4. Use the intermediate signals to define the logic equations for f.
  //    Use an always_comb block to specify the logic equations.
  always_comb begin
    if (w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8)
      f = 1;
    else
      f = 0;
  end

endmodule
