module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // state encoding
    typedef enum logic [1:0] {
        OFF = 2'b00, 
        ON = 2'b01
    } states_t;
    
    states_t state, next_state;
    
    // state transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end
    
    // state flip-flops
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= OFF;
        else 
            state <= next_state;
    end
    
    // output logic
    always @(state) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
        endcase
    end
    
endmodule
