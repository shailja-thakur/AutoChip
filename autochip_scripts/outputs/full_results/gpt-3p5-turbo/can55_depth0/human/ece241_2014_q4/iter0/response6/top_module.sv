module top_module (
    input clk,
    input x,
    output z
);
    reg d1, d2, d3;
    wire x_xor_d1, x_and_not_d2, x_or_not_d3;

    xor x_xor (x, d1, x_xor_d1);
    and x_and (x, ~d2, x_and_not_d2);
    or x_or (x, ~d3, x_or_not_d3);

    dff flipflop1 (.clk(clk), .d(x_xor_d1), .q(d1));
    dff flipflop2 (.clk(clk), .d(x_and_not_d2), .q(d2));
    dff flipflop3 (.clk(clk), .d(x_or_not_d3), .q(d3));
    
    xnor xnor_gate (x_xor_d1, x_and_not_d2, x_or_not_d3, z);
endmodule
module xor (input a, input b, output c);
   assign c = a^b;
endmodule
module and (input a, input b, output c);
   assign c = a&b;
endmodule
module or (input a, input b, output c);
   assign c = a|b;
endmodule
module dff (input clk, input d, output q);
   reg q;
   always @(posedge clk)
      q<=d;
endmodule
module xnor (input a, input b, input c, output d);
   wire ab, abc;
   xor xor_gate1 (a, b, ab);
   xor xor_gate2 (ab, c, abc);
   not not_gate (abc, d);
endmodule
