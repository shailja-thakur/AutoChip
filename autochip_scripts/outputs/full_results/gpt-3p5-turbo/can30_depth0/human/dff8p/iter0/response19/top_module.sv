module top_module(
  	  input clk,
	  input [7:0] d,
	  input reset,
	  output reg [7:0] q);
	
	  reg [7:0] dff [0:7];
	  reg [7:0] q_temp;
	
	  always @(posedge clk, negedge reset) begin
	    if (reset == 1'b0) begin
	      q_temp <= 8'b00110100;
	      for (int i = 0; i < 8; i=i+1) begin
	        dff[i] <= q_temp[i];
	        q[i] <= dff[i];
	      end
	    end
	    else begin
	      q_temp <= d;
	      for (int i = 0; i < 8; i=i+1) begin
	        dff[i] <= q_temp[i];
	        q[i] <= dff[i];
	      end
	    end
	  end
endmodule
