module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

xor gate_xor (x, q1, d1);
and gate_and (x, q2, d2);
or gate_or (x, q3, d3);

d_flip_flop dff1 (clk, d1, q1);
d_flip_flop dff2 (clk, ~d2, q2);
d_flip_flop dff3 (clk, ~d3, q3);

xnor gate_xnor (q1, q2, q3, z);

endmodule
module xor (input a, b, output y);
    assign y = a ^ b;
endmodule
module and (input a, b, output y);
    assign y = a & b;
endmodule
module or (input a, b, output y);
    assign y = a | b;
endmodule
module xnor (input a, b, c, output y);
    assign y = ~(a ^ b ^ c);
endmodule
module d_flip_flop (input clk, d, output reg q);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
