module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @*
	begin
	    case({y[3], y[2], y[1]})
	        // A (0)
	        3'b000:
	            if (w)
	                Y2 = 0;
	            else
	                Y2 = 1;
	            
	        // B (1)
	        3'b001:
	            if (w)
	                Y2 = 0;
	            else
	                Y2 = 1;
	                
	        // C (2)
	        3'b010:
	            if (w)
	                Y2 = 1;
	            else
	                Y2 = 0;
	                
	        // D (3)
	        3'b011:
	            if (w)
	                Y2 = 0;
	            else
	                Y2 = 1;
	                
	        // E (4)
	        3'b100:
	            if (w)
	                Y2 = 0;
	            else
	                Y2 = 1;
	                
	        // F (5)
	        3'b101:
	            if (w)
	                Y2 = 1;
	            else
	                Y2 = 0;
	    endcase
	end
endmodule
