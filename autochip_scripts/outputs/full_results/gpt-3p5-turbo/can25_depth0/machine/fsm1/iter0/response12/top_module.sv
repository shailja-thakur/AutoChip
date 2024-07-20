module top_module (
	input clk,
	input in,
	input areset,
	output out
);

    reg state, next_state;
    
    always @(posedge clk) begin
        if (areset)
            state <= 0;
        else
            state <= next_state;
    end
    
    always @(state, in) begin
        case (state)
            0: begin
                if (in)
                    next_state = 0;
                else
                    next_state = 1;
                out = 1'b0;
            end
            
            1: begin
                if (in)
                    next_state = 1;
                else
                    next_state = 0;
                out = 1'b1;
            end
        endcase
    end
    
endmodule
