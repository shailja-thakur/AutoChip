module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	always @(posedge clk)
	begin
	    case({x, y})
	        2'b00:
	        begin
	            Y0 <= 1'b0;
	            case(y)
	                3'b000: z = 1'b0;
	                3'b001: z = 1'b0;
	                3'b010: z = 1'b0;
	                3'b011: z = 1'b1;
	                3'b100: z = 1'b1;
	                default: z = 1'b0;
	            endcase
	        end
	        
	        2'b01:
	        begin
	            Y0 <= 1'b0;
	            case(y)
	                3'b001: z = 1'b0;
	                3'b011: z = 1'b0;
	                default: z = 1'b0;
	            endcase
	        end
	        
	        2'b10:
	        begin
	            Y0 <= 1'b0;
	            case(y)
	                3'b010: z = 1'b0;
	                3'b001: z = 1'b0;
	                3'b011: z = 1'b1;
	                default: z = 1'b0;
	            endcase
	        end
	        
	        2'b11:
	        begin
	            Y0 <= 1'b1;
	            case(y)
	                3'b011: z = 1'b1;
	                3'b100: z = 1'b1;
	                default: z = 1'b0;
	            endcase
	        end
	        
	        default:
	        begin
	            Y0 <= 1'b0;
	            z = 1'b0;
	        end
	    endcase
	end
	
endmodule
