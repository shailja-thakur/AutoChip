module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

wire xor_gate, and_gate, or_gate;

// XOR gate
assign xor_gate = x ^ q1;

// AND gate
assign and_gate = x & ~q2;

// OR gate 
assign or_gate = x | ~q3;

// D Flip-Flops
always @(posedge clk) begin
    q1 <= xor_gate;
    q2 <= and_gate;
    q3 <= or_gate;
end

// XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

endmodule
