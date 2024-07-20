module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] carry;
  
  // Instantiating full adders
  // Connect the inputs and outputs of the full adders
  generate
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin : adder_loop
      full_adder FA (
        .x(x[i]),
        .y(y[i]),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i+1])
      );
    end
  endgenerate

  // Connect the overflow bit
  assign sum[4] = carry[4];

endmodule
module full_adder (
  input x,
  input y,
  input cin,
  output sum,
  output cout
);
  wire w1, w2, w3;
  
  // Implement the XOR gates
  xor(xor1, x, y);
  xor(xor2, xor1, cin);
  
  // Implement the AND gates
  and(and1, x, y);
  and(and2, x, cin);
  and(and3, y, cin);
  
  // Implement the OR gate
  or(or1, and1, and2, and3);
  
  // Assign the outputs
  assign sum = xor2;
  assign cout = or1;
  
endmodule
