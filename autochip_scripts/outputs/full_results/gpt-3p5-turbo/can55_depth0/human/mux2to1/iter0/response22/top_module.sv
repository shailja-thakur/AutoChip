module top_module (
	input a,
	input b,
	input sel,
	output out
);

  // Define internal wire to hold the selected input
  wire selected_input;

  // Instantiate the multiplexer module
  // Pass the inputs and the select as arguments
  Mux2to1 mux1(.in0(a), .in1(b), .sel(sel), .out(selected_input));

  // Assign the selected input to the output
  assign out = selected_input;

endmodule
module Mux2to1 (
  input in0,
  input in1,
  input sel,
  output out
);
  // Logic for selecting the input based on sel value
  assign out = sel ? in1 : in0;
endmodule
