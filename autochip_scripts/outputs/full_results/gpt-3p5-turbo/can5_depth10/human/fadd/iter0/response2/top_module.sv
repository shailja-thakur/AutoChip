module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

  // Declare internal wire variables
  wire x;
  wire y;
  wire z;

  // Instantiate the full adder module
  full_adder FA1 (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(x),
    .cout(y)
  );

  // Instantiate the second full adder module
  full_adder FA2 (
    .a(x),
    .b(y),
    .cin(z),
    .sum(sum),
    .cout(cout)
  );
  
  // Instantiation of full adder module
  full_adder FA (
    .a ( a ),
    .b ( b ),
    .cin ( cin ),
    .sum ( sum ),
    .cout ( cout )
  );

endmodule
