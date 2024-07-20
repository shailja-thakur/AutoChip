module top_module (
    input a,
    input b,
    output sum,
    output cout
);
  reg sum;
  reg cout;

  // Assign statement to perform addition
  always @(a or b) begin
    sum = a + b;
    cout = a & b; // Carry out is the result of bitwise AND operation
  end
  
  // Output assignments
  assign sum = sum;
  assign cout = cout;
  
endmodule
