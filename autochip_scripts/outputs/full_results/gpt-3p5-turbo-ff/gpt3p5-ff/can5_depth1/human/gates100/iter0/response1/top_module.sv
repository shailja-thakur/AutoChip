module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

wire [99:0] wire_and;
wire [99:0] wire_or;
wire wire_xor;

and gate_and(wire_and, in); // 100-input AND gate

or gate_or(wire_or, in); // 100-input OR gate

xor gate_xor(wire_xor, in); // 100-input XOR gate

assign out_and = wire_and[99]; // Output of AND gate
assign out_or = wire_or[99]; // Output of OR gate
assign out_xor = wire_xor; // Output of XOR gate

endmodule
