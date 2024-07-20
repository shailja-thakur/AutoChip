module top_module (
    input a,
    input b,
    output q
);

    // Implement the circuit logic here
	not gate1 (a, na);
	not gate2 (b, nb);
	or gate3 (na, nb, q);

endmodule
