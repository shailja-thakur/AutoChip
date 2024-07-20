module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

// Define intermediate signals for each input condition
wire cond_0;
wire cond_1;
wire cond_2;
wire cond_4;
wire cond_5;
wire cond_6;
wire cond_7;
wire cond_9;
wire cond_10;
wire cond_13;
wire cond_14;
wire cond_15;

// Assign intermediate signals to input conditions
assign cond_0 = (a == 0 && b == 0 && c == 0 && d == 0);
assign cond_1 = (a == 0 && b == 0 && c == 0 && d == 1);
assign cond_2 = (a == 0 && b == 0 && c == 1 && d == 0);
assign cond_4 = (a == 0 && b == 1 && c == 0 && d == 0);
assign cond_5 = (a == 0 && b == 1 && c == 0 && d == 1);
assign cond_6 = (a == 0 && b == 1 && c == 1 && d == 0);
assign cond_7 = (a == 0 && b == 1 && c == 1 && d == 1);
assign cond_9 = (a == 1 && b == 0 && c == 0 && d == 1);
assign cond_10 = (a == 1 && b == 0 && c == 1 && d == 0);
assign cond_13 = (a == 1 && b == 1 && c == 0 && d == 1);
assign cond_14 = (a == 1 && b == 1 && c == 1 && d == 0);
assign cond_15 = (a == 1 && b == 1 && c == 1 && d == 1);

// Determine the output out_sop in minimum sum-of-products form
assign out_sop = !(cond_0 || cond_1 || cond_4 || cond_5 || cond_6 || cond_9 || cond_10 || cond_13 || cond_14);

// Determine the output out_pos in minimum product-of-sums form
assign out_pos = (cond_2 || cond_7 || cond_15);

endmodule
