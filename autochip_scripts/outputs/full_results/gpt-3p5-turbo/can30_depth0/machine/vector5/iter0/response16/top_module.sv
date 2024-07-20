module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

    wire [4:0] w_a, w_b, w_c, w_d, w_e;
    wire [4:0] w_not_a, w_not_b, w_not_c, w_not_d, w_not_e;

    assign w_a = {5{a}};
    assign w_b = {5{b}};
    assign w_c = {5{c}};
    assign w_d = {5{d}};
    assign w_e = {5{e}};

    assign w_not_a = ~w_a;
    assign w_not_b = ~w_b;
    assign w_not_c = ~w_c;
    assign w_not_d = ~w_d;
    assign w_not_e = ~w_e;

    assign out = w_not_a ^ w_not_b ^ w_not_c ^ w_not_d ^ w_not_e ^ w_a ^ w_b ^ w_c ^ w_d ^ w_e;

endmodule
