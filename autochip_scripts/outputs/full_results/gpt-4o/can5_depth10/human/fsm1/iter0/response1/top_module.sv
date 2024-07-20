module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
    
    typedef enum {A, B} state_t;
    state_t current_state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(*) begin
        case (current_state)
            A: if (in) next_state = A; else next_state = B;
            B: if (in) next_state = B; else next_state = A;
            default: next_state = B;
        endcase
    end
    
    always @(*) begin
        case (current_state)
            A: out = 0;
            B: out = 1;
            default: out = 1;
        endcase
    end
    
endmodule
