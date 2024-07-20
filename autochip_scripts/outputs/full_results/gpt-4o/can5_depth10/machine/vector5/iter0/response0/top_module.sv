module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

    wire [24:0] not_vector;
    wire [24:0] vector;

    assign not_vector = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign vector = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign out = not_vector ^ vector;

endmodule
