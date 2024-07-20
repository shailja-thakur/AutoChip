module top_module (
	input [4:1] x,
	output logic f
);

// Implementing the function f using the Karnaugh map

always_comb begin
	f = (x[1] & x[2] & x[4]) | (x[1] & !x[2] & !x[3] & !x[4]) | (x[1] & x[2] & !x[3]) | (!x[1] & !x[2] & !x[3] & x[4]);
end

endmodule
