module top_module (
	input clk,
	input areset,
	input x,
	output z
);
    reg [1:0] state;
    reg z_reg;
    
    always @ (posedge clk or posedge areset) begin
    	if (areset)
    		state <= 2'b00;
    	else begin
    		case(state)
    			2'b00: begin
    				if(x)
    					state <= 2'b01;
    				else
    					state <= 2'b00;
    			end
    			2'b01: begin
    				if(x)
    					state <= 2'b00;
    				else
    					state <= 2'b01;
    			end
    			default: state <= 2'b00;
    		endcase
    	end
    end
    
    always @ (posedge clk) begin
    	if (state == 2'b00)
    		z_reg <= 1'b0;
    	else if (state == 2'b01)
    		z_reg <= 1'b1;
    end
    
    assign z = z_reg;

endmodule
