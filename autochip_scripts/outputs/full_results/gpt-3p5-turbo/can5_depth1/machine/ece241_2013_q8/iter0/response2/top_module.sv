module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
    reg state, next_state;
    parameter S = 2'b00;
    parameter S1 = 2'b01;
    parameter S10 = 2'b10;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S;
        else
            state <= next_state;
    end
    
    always @* begin
        case ({x, state})
            2'b00: next_state = S;
            2'b01: next_state = S1; 
            2'b10: next_state = S10;
            default: next_state = state;
        endcase
    end
    
    always @(state) begin
        case (state)
            S, S1: z = 1'b0;
            S10: z = x;
        endcase
    end
endmodule
