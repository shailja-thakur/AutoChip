module top_module (
	input [4:1] x,
	output logic f
);

assign f = ((x[1] == 0 && x[2] == 0) && (x[3] == 0 && x[4] == 1))  // d-case: f can be either 0 or 1
        || ((x[1] == 0 && x[2] == 1) && (x[3] == 0 && x[4] == 0))  // d-case: f can be either 0 or 1
        || ((x[1] == 1 && x[2] == 0) && (x[3] == 0 && x[4] == 0))  // d-case: f can be either 0 or 1
        || ((x[1] == 1 && x[2] == 0) && (x[3] == 0 && x[4] == 1))  // d-case: f can be either 0 or 1
        || ((x[1] == 1 && x[2] == 0) && (x[3] == 1 && x[4] == 0))  // f = 1
        || ((x[1] == 1 && x[2] == 0) && (x[3] == 1 && x[4] == 1))  // f = 1
        || ((x[1] == 1 && x[2] == 1) && (x[3] == 0 && x[4] == 0))  // f = 0
        || ((x[1] == 1 && x[2] == 1) && (x[3] == 0 && x[4] == 1))  // d-case: f can be either 0 or 1
        || ((x[1] == 1 && x[2] == 1) && (x[3] == 1 && x[4] == 0)); // d-case: f can be either 0 or 1

endmodule
