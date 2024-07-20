module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
  
  // Declare a flip-flop to hold the value of the data input
  logic [1:0] register;
  
  always_ff @(posedge clk or posedge r) begin
    if (r) begin
      // Reset is active, set the output to 0
      register <= 2'b00;
    end else begin
      // Reset is not active, store the value of the data input
      register <= d;
    end
  end
  
  assign q = register[0];
  
endmodule
