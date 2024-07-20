module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

// States
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state; // state register

// Outputs
reg f_out, g_out; // output registers

// State machine logic
always @(posedge clk, negedge resetn) begin
	if (!resetn) begin
		state <= A;
        f_out <= 0;
        g_out <=0;
	end else begin
		state <= next_state;
        f_out <= f_out; // Retain previous value of f_out
        g_out <= g_out; // Retain previous value of g_out
	end
end

always @* begin
	next_state = state;
	
	case (state)
		A: begin
		    if (!resetn) begin
		        next_state = A;
		    end else begin
		    	if (x == 1'b1 && y == 1'b0) begin
		    		next_state = B;
		    		f_out <= 1'b1;
		    	end else begin
		    		next_state = A;
		    		f_out <= 1'b0;
		    	end
		    end
		end
		
		B: begin
		    if (!resetn) begin
		        next_state = A;
		    end else begin
		    	if (x == 1'b1 && y == 1'b0) begin
		    		next_state = C;
		    	end else begin
		    		next_state = A;
		    	end
		    	f_out <= 1'b0; // Reset f_out to 0 after one clock cycle
		    end
		end
		
		C: begin
		    if (!resetn) begin
		        next_state = A;
		    end else begin
		    	if (x == 1'b1 && y == 1'b1) begin
		    		next_state = D;
		    		g_out <= 1'b1;
		    	end else if (x == 1'b1 && y == 1'b0) begin
		    		next_state = B;
		    		f_out <= 1'b1;
		    	end else begin
		    		next_state = A;
		    		g_out <= 1'b0;
		    		f_out <= 1'b0;
		    	end
		    end
		end
		
		D: begin
		    if (!resetn) begin
		        next_state = A;
		    end else begin
		    	if (x == 1'b1 && y == 1'b1) begin
		    		next_state = D;
		    		g_out <= 1'b1;
		    	end else if (x == 1'b1 && y == 1'b0) begin
		    		next_state = B;
		    		f_out <= 1'b1;
		    	end else begin
		    		next_state = A;
		    		g_out <= 1'b0;
		    		f_out <= 1'b0;
		    	end
		    end
		end
	endcase
end

assign f = f_out;
assign g = g_out;

endmodule
