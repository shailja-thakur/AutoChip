module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON = 2'b01
    } state_t;

    // Current state and next state variables
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON:  if (k) next_state = OFF;
                 else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) current_state <= OFF;
        else current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
