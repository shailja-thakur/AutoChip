module top_module(
  input wire x,
  input wire y,
  output wire z
);

  wire [1:0] a1_z, a2_z, b1_z, b2_z;
  
  A a1(.x(x), .y(y), .z(a1_z));
  B b1(.x(x), .y(y), .z(b1_z));
  
  A a2(.x(x), .y(y), .z(a2_z));
  B b2(.x(x), .y(y), .z(b2_z));
  
  wire or_out1, or_out2;
  assign or_out1 = a1_z[0] | b1_z[0];
  assign or_out2 = a2_z[0] | b2_z[0];
  
  wire and_out;
  assign and_out = or_out1 & or_out2;

  assign z = x ^ and_out;

endmodule
module A(
  input wire x,
  input wire y,
  output reg [1:0] z
);

  always @(*)
  begin
    z = (x ^ y) & x;
  end
  
endmodule
module B(
  input wire x,
  input wire y,
  output reg [1:0] z
);

  always @(*)
  begin
    z = (x ^ y) & x;
  end

endmodule
