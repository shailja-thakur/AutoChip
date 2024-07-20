module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
    	if (reset) begin
    		state <= 2'b0;
    	end else begin
    		case (state)
    			2'b0: begin
    				if (j) begin
    					state <= 2'b1;
    				end else begin
    					state <= 2'b0;
    				end
    			end
    			2'b1: begin
    				if (k) begin
    					state <= 2'b0;
    				end else begin
    					state <= 2'b1;
    				end
    			end
    		endcase
    	end
    end

    always @(*) begin
    	case (state)
    		2'b0: out = 1'b0;
    		2'b1: out = 1'b1;
    	endcase
    end

endmodule
