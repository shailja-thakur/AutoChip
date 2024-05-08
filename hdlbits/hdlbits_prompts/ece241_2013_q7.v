// A JK flip-flop has the below truth table. Implement a JK flip-flop with only a D-type flip-flop and gates. Note: Qold is the output of the D flip-flop before the positive clock edge.

J	K	Q
0	0	Qold
0	1	0
1	0	1
1	1	~Qold

module top_module (
    input clk,
    input j,
    input k,
    output Q);

    // Insert your code here 

endmodule
