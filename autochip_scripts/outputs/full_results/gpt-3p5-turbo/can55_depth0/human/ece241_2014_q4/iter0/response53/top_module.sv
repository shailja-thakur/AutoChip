module top_module (
    input clk,
    input x,
    output z
);

reg d_ff1, d_ff2, d_ff3;
wire q1, q2, q3;
wire z_out;

assign z = z_out;

xor gate_xor (q1, d_ff1, x);
and gate_and (q2, ~d_ff2, x);
or gate_or (q3, ~d_ff3, x);

xnor gate_xnor (z_out, q1, q2, q3);

always @(posedge clk) begin
    d_ff1 <= q1;
    d_ff2 <= q2;
    d_ff3 <= q3;
end

endmodule
module xor (output o, input a, input b);
    assign o = a ^ b;
endmodule
module and (output o, input a, input b);
    assign o = a & b;
endmodule
module or (output o, input a, input b);
    assign o = a | b;
endmodule
module xnor (output o, input a, input b, input c);
    assign o = ~(a ^ b ^ c);
endmodule
