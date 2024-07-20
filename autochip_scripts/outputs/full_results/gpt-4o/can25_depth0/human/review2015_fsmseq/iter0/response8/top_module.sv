module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        S1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Combinatorial logic for next state
    always @(*) begin
        next_state = current_state; // Default stay in current state
        case (current_state)
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
                if (data)
                    next_state = S11; // Remain in S11 if data is 1
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = S1101;
                else
                    next_state = IDLE;
            end
            S1101: begin
                // Once we reach the final state, stay there
                next_state = S1101;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == S1101)
            start_shifting <= 1;
    end

endmodule
