module A(
	input x,
	input y,
	output z);
	
	assign z = (x ^ y) & x;
	
endmodule
module B(
    input x,
    input y,
    output z);

    assign z = (x & !y) | (!x & y);
    
endmodule
module top_module(
	input x,
	input y,
	output z);
  
    wire z1, z2, z3, z4, or_out, and_out;

    A A1(x, y, z1);
    A A2(x, y, z2);
    B B1(x, y, z3);
    B B2(x, y, z4);
  
    OR2 my_or(z1, z3, or_out);
    AND2 my_and(z2, z4, and_out);
    XOR2 my_xor(or_out, and_out, z);
	
endmodule
module OR2(
  input a,
  input b,
  output z);

  assign z = a | b;

endmodule
module AND2(
  input a,
  input b,
  output z);

  assign z = a & b;

endmodule
module XOR2(
  input a,
  input b,
  output z);

  assign z = a ^ b;

endmodule
