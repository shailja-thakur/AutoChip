module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);
	reg [2:0] Y;
	
	always @(posedge clk)begin
	    case({y,x})
	        3'd0: begin
	            Y <= 3'b000;
	        end
	        3'd1: begin
	            Y <= 3'b001;
	        end
	        3'd2: begin
	            Y <= 3'b010;
	        end
	        3'd3: begin
	            Y <= 3'b001;
	        end
	        3'd4: begin
	            Y <= 3'b011;
	        end
	        default: begin
	            Y <= 3'b000;
	        end
	    endcase
	end
	
	always @(posedge clk) begin
	    case(Y)
	        3'b000: begin
	            Y0 <= 1'b0;
	            z <= 1'b0;
	        end
	        3'b001: begin
	            Y0 <= 1'b0;
	            z <= 1'b0;
	        end
	        3'b010: begin
	            Y0 <= 1'b0;
	            z <= 1'b0;
	        end
	        3'b100: begin
	            Y0 <= 1'b0;
	            z <= 1'b1;
	        end
	        3'b011: begin
	            Y0 <= 1'b1;
	            z <= 1'b1;
	        end
	        default: begin
	            Y0 <= 1'b0;
	            z <= 1'b0;
	        end
	    endcase
	end
endmodule
