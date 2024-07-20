module top_module (
    input a,
    input b,
    input sel,
    output out
);

	assign out = (sel == 1'b1) ? b : a;

endmodule
