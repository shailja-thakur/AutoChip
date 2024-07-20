module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

  wire p1y_temp;
  wire p2y_temp;
  
  and gate_p1(
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(p1y_temp)
  );
  
  and gate_p2(
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(p2y_temp)
  );
  
  not inv_p1(
    .a(p1y_temp),
    .y(p1y)
  );
  
  not inv_p2(
    .a(p2y_temp),
    .y(p2y)
  );
   
endmodule
