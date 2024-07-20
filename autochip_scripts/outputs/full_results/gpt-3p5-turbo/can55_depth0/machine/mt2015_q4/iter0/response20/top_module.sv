module top_module (
    input x,
    input y,
    output z
);
   wire a, b;

   // First gate
   and_gate AND1 (.a(x), .b(y), .z(a));

   // Second gate
   and_gate AND2 (.a(y), .b(x), .z(b));

   // Third gate
   or_gate OR1 (.a(a), .b(b), .z(z));
endmodule
module and_gate (
    input a,
    input b,
    output z
);
   assign z = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output z
);
   assign z = a | b;
endmodule
