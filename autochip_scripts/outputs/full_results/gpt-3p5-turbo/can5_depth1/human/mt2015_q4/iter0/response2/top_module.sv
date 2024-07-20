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
  
  reg z;
  
  always @(x or y) begin
    case({x, y})
      2'b00: z = 1;
      2'b01: z = 0;
      2'b10: z = 0;
      2'b11: z = 1;
    endcase
  end
  
endmodule
module top_module(
  input x,
  input y,
  output z);
  
  wire a_out, b_out;
  
  A a1(.x(x), .y(y), .z(a_out));
  A a2(.x(x), .y(y), .z(b_out));
  
  or_gate or1(.a(a_out), .b(b_out), .z(z));
  
endmodule
module or_gate (
  input a,
  input b,
  output z);
  
  assign z = a | b;
  
endmodule
module and_gate (
  input a,
  input b,
  output z);
  
  assign z = a & b;
  
endmodule
module xor_gate (
  input a,
  input b,
  output z);
  
  assign z = a ^ b;
  
endmodule
