module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define state encoding
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON:  if (k) next_state = OFF;
                 else next_state = ON;
            default: next_state = OFF;
        endcase
    end
    
    // State register (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic (Moore machine)
    always @(*) begin
        case(state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
        endcase
    end
endmodule
