module top_module (
	input clk,
	input in,
	input areset,
	output out
);

  	reg [1:0] state;
  	reg out_reg;

  	parameter A = 2'b00;
  	parameter B = 2'b01;
  	parameter C = 2'b10;
  	parameter D = 2'b11;

  	always @(posedge clk or areset)
  	begin
    		if (areset)
    			state <= A;
    		else
        		case (state)
            		A: begin
                		if (in)
                			state <= B;
                		else
                  			state <= A;
                		out_reg <= 0;
            		end
            		B: begin
                		if (in)
                  			state <= C;
                		else
                  			state <= B;
                		out_reg <= 0;
            		end
            		C: begin
                		if (in)
                  			state <= D;
                		else
                  			state <= A;
                		out_reg <= 0;
            		end
            		D: begin
                		if (in)
                  			state <= B;
                		else
                  			state <= C;
                		out_reg <= 1;
            		end
        		endcase
  	end

  	assign out = out_reg;

endmodule
