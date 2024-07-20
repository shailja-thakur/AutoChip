module top_module (
  input a,
  input b,
  input sel,
  output out
);
  // Declare wire to store the selected value
  wire selected_value;

  // Assign the selected value based on the value of sel
  assign selected_value = (sel == 1) ? b : a;

  // Assign the selected value to the output port
  assign out = selected_value;
endmodule
