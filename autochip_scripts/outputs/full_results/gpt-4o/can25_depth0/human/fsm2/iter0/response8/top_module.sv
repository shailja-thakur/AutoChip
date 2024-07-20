module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {OFF = 1'b0, ON = 1'b1} state_t;
    state_t state, next_state;

    // State transitions
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= OFF; // Asynchronous reset to OFF state
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON:  if (k) next_state = OFF;
                 else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // Output logic
    always @(state) begin
        case(state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
        endcase
    end

endmodule
