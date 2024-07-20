module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
  
  always_comb begin
    min = a; // Assign initial value of a to min
    
    // Compare min with b and update if necessary
    if (b < min)
      min = b;
    
    // Compare min with c and update if necessary
    if (c < min)
      min = c;
    
    // Compare min with d and update if necessary
    if (d < min)
      min = d;
  end
  
endmodule
