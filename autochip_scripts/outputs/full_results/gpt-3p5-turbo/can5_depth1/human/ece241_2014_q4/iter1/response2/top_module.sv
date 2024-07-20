module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire xor_out, and_out, or_out; // Define wires for intermediate gate outputs

and_gate xor1 (d1, xor_out, d1); // Connect D flip-flop output to XOR gate input
and_gate and1 (d2, and_out, ~d2); // Connect complement of D flip-flop output to AND gate input
and_gate or1 (d3, or_out, ~d3); // Connect complement of D flip-flop output to OR gate input

xnor_gate xnor1 (xor_out, and_out, or_out, z); // Connect outputs of XOR, AND, and OR gates to XNOR gate

always @(posedge clk) begin
    if (x) begin
        d1 <= xor_out;
        d2 <= and_out;
        d3 <= or_out;
    end
end

endmodule
module and_gate (
    input a,
    input b,
    output y
);

assign y = a & b;

endmodule
module xnor_gate (
    input a,
    input b,
    input c,
    output y
);

assign y = ~(a ^ b ^ c);

endmodule
