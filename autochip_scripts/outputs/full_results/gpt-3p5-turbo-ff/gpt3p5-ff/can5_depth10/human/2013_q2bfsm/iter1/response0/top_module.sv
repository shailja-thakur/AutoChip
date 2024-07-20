module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [1:0] state, next_state;

// state A
parameter A = 2'b00;

// state B
parameter B = 2'b01;

// state C
parameter C = 2'b10;


always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= A;
		f <= 0;
		g <= 0;
	end
	else begin
		state <= next_state;
        
        case(state)
            
            A: begin
                f <= 0;
                
                if (x == 1'b1 && $past(x) == 1'b0 && $past($past(x)) == 1'b1)
                    next_state <= B;
                else
                    next_state <= A;
            end
            
            B: begin
                if (y == 1'b1) begin
                    g <= 1;
                    next_state <= C;
                end
                else begin
                    g <= 0;
                    next_state <= A;
                end
            end
            
            C: begin
                if (y == 1'b1) begin
                    g <= 1;
                    next_state <= C;
                end
                else begin
                    g <= 0;
                    next_state <= A;
                end
            end
        endcase
	end
end

endmodule
