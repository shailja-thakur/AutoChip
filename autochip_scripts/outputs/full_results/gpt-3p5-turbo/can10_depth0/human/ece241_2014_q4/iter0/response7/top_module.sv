module top_module (
	input clk,
	input x,
	output z
);

reg [2:0] flip_flop_outputs;
wire [2:0] flip_flop_outputs_complement;

D_FF ff_0(clk, x, 1'b0, flip_flop_outputs[0]);
D_FF ff_1(clk, flip_flop_outputs[0], ~flip_flop_outputs[0], flip_flop_outputs[1]);
D_FF ff_2(clk, flip_flop_outputs[1], ~flip_flop_outputs[1], flip_flop_outputs[2]);

xor gate_0(flip_flop_outputs[0], flip_flop_outputs[0], flip_flop_outputs[3]);
and gate_1(flip_flop_outputs[1], ~flip_flop_outputs[1], flip_flop_outputs[4]);
or gate_2(flip_flop_outputs[2], ~flip_flop_outputs[2], flip_flop_outputs[5]);

xnor gate_3(flip_flop_outputs[3], flip_flop_outputs[4], flip_flop_outputs[5], z);

endmodule
module D_FF (
    input clk,
    input d,
    input reset,
    output reg q
);
    always @(posedge clk)
    begin
        if (reset == 1'b1)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
module xor (
    input a,
    input b,
    output c
);
    assign c = a ^ b;
endmodule
module and (
    input a,
    input b,
    output c
);
    assign c = a & b;
endmodule
module or (
    input a,
    input b,
    output c
);
    assign c = a | b;
endmodule
module xnor (
    input a,
    input b,
    input c,
    output d
);
    assign d = ~(a ^ b ^ c);
endmodule
