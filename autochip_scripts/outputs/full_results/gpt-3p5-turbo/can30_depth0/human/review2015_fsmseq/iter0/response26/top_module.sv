module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;
		else
			state <= next_state;
	end
	
	always @(state or data) begin
	  next_state = 4'b0000;
	  start_shifting = 0;
	  
	  case (state)
	    4'b0000: begin
	      if (data)
	        next_state = 4'b0001;
	    end
	    
	    4'b0001: begin
	      if (data)
	        next_state = 4'b0011;
	      else
	        next_state = 4'b0000;
	    end
	    
	    4'b0011: begin
	      if (data)
	        next_state = 4'b0110;
	      else
	        next_state = 4'b0000;
	    end
	    
	    4'b0110: begin
	      if (data)
	        next_state = 4'b1101;
	      else
	        next_state = 4'b0000;
	    end
	    
	    4'b1101: begin
	      next_state = 4'b0000;
	      start_shifting = 1;
	    end
	  endcase
	end
	
endmodule
