module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    always @(posedge clk) begin
	    case(amount)
	        2'b00: begin
	            if (ena)
	                q <= data << 1;
	            else if (load)
	                q <= data;
	        end
	        2'b01: begin
	            if (ena)
	                q <= data << 8;
	            else if (load)
	                q <= data;
	        end
	        2'b10: begin
	            if (ena)
	                q <= $signed(data) >> 1;
	            else if (load)
	                q <= data;
	            end
	        2'b11: begin
	            if (ena)
	                q <= $signed(data) >> 8;
	            else if (load)
	                q <= data;
	        end
	    endcase
    end
endmodule
