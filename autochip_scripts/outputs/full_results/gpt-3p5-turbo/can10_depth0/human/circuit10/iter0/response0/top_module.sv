module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

    reg q_reg;
    reg state_reg;
    reg q_next;
    reg state_next;
    
    initial begin
        q_reg = 0;
        state_reg = 0;
    end
    
    always @(posedge clk) begin
        q_reg <= q_next;
        state_reg <= state_next;
    end
    
    always @(a, b, state_reg) begin
        case(state_reg)
            0: begin
                q_next = a & b;
                state_next = a;
            end
            1: begin
                q_next = a | b;
                state_next = b;
            end
        endcase
    end
    
    assign q = q_reg;
    assign state = state_reg;
    
endmodule
