module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State register (sequential logic)
    always @(posedge clk) begin
        if (reset) 
            state <= OFF;
        else 
            state <= next_state;
    end

    // Output logic (depends only on the state)
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
