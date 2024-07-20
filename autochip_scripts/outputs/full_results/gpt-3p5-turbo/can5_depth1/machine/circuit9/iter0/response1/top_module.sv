module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

  // Register to hold previous value of q
  reg [2:0] q_prev;

  always @(posedge clk) begin
    // Set q_prev to current value of q
    q_prev <= q;

    if(a) begin
      // Set q to 4 when a is 1
      q <= 4;
    end else begin
      if(q_prev == 6) begin
        // Set q to 0 when a is 0 and q is 6
        q <= 0;
      end else begin
        // Increase q by 1 when a is 0 and q is not 6
        q <= q_prev + 1;
      end
    end
  end
  
endmodule
