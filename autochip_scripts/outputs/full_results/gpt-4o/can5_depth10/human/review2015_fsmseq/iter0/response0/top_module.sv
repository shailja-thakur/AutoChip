module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001, // State after first '1'
        S11  = 3'b010, // State after '11'
        S110 = 3'b011, // State after '110'
        S1101= 3'b100  // State after '1101'
    } state_t;

    state_t current_state, next_state;

    // State Machine: Combinational logic
    always @(*) begin
        case (current_state)
            IDLE:  next_state = (data) ? S1 : IDLE;
            S1:    next_state = (data) ? S11 : IDLE;
            S11:   next_state = (data) ? S11 : S110;
            S110:  next_state = (data) ? S1101 : IDLE;
            S1101: next_state = S1101; // Stay in S1101 indefinitely
            default: next_state = IDLE;
        endcase
    end

    // State Machine: Sequential logic
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == S1101)
            start_shifting <= 1;
    end

endmodule
