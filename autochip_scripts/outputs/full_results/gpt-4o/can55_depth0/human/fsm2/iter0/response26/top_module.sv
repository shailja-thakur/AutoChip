module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        OFF = 2'b00, // State when output is 0
        ON  = 2'b01  // State when output is 1
    } state_t;

    state_t state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // Sequential logic to assign the current state
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
