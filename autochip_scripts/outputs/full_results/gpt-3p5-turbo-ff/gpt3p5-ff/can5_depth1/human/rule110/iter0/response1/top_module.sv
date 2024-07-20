module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
	  if (load == 1) // synchronous load
	    q <= data;
	  else begin
	    q[0] = (q[1] & q[0])         | (q[2] & q[1])         | (~q[2] & q[0]);
	    q[1] = (q[1] & q[0])         | (~q[2] & ~q[0])       | (~q[2] & q[1]);
	    q[2] = (~q[1] & q[0])        | (q[2] & ~q[0])        | (~q[2] & q[1]);
	    for (int i = 3; i < 509; i++) begin
	      q[i] = (~q[i-3] & q[i-1])   | (~q[i] & ~q[i-1])     | (q[i] & ~q[i-1]) | (q[i-3] & q[i-1]);
	    end
	    q[509] = (~q[506] & q[508])  | (~q[509] & ~q[508])   | (q[509] & ~q[508]) | (q[506] & q[508]);
	    q[510] = (~q[507] & q[509])  | (~q[510] & ~q[509])   | (q[510] & ~q[509]) | (q[507] & q[509]);
	    q[511] = (~q[508] & q[510])  | (~q[511] & ~q[510])   | (q[511] & ~q[510]) | (q[508] & q[510]);
	  end
	end

endmodule
