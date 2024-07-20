module top_module (
	input clk,
	input x,
	output z
);

    reg d0, d1, d2;
    wire q0, q1, q2;
    
    xor_gate xor1(q0, x, d0);
    and_gate and1(q1, ~q1, d1);
    or_gate or1(q2, ~q2, d2);
    
    d_flip_flop flipflop0(.clk(clk), .d(q0), .q(q0));
    d_flip_flop flipflop1(.clk(clk), .d(q1), .q(q1));
    d_flip_flop flipflop2(.clk(clk), .d(q2), .q(q2));
    
    xnor_gate xnor1(z, q0, q1, q2);
    
endmodule
module xor_gate (
    output xor_out,
    input xor_in1,
    input xor_in2
);

    assign xor_out = xor_in1 ^ xor_in2;

endmodule
module and_gate (
    output and_out,
    input and_in1,
    input and_in2
);

    assign and_out = and_in1 & and_in2;

endmodule
module or_gate (
    output or_out,
    input or_in1,
    input or_in2
);

    assign or_out = or_in1 | or_in2;

endmodule
module d_flip_flop (
    input clk,
    input d,
    output q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
module xnor_gate (
    output xnor_out,
    input xnor_in1,
    input xnor_in2,
    input xnor_in3
);

    assign xnor_out = (~(xnor_in1 ^ xnor_in2)) ^ xnor_in3;

endmodule
