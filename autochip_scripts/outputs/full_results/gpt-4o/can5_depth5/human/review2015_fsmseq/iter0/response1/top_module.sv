module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum logic [1:0] {
        IDLE         = 2'b00,
        S1           = 2'b01,
        S11          = 2'b10,
        S110         = 2'b11,
        FOUND        = 2'b00 // Reusing state IDLE as FOUND state
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state logic and output logic
    always @(*) begin
        next_state = state;
        start_shifting = 0;
        
        case (state)
            IDLE: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (~data)
                    next_state = S110;
                else
                    next_state = S1; // stay in S11 if another '1' is received
            end
            S110: begin
                if (data)
                    next_state = FOUND;
                else
                    next_state = IDLE;
            end
            FOUND: begin
                start_shifting = 1;
                next_state = FOUND; // Remain in the FOUND state forever once entered
            end
        endcase
    end
endmodule
