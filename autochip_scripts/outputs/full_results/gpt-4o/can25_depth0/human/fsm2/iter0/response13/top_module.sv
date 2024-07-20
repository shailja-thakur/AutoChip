module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j == 1'b1) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k == 1'b1) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: next_state = OFF;
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
    
endmodule
