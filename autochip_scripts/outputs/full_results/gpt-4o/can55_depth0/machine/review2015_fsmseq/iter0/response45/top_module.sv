module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State declaration
    typedef enum logic [2:0] {
        S      = 3'b000,
        S1     = 3'b001,
        S11    = 3'b010,
        S110   = 3'b011,
        DONE   = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_comb begin
        case (current_state)
            S: begin
                if (data)
                    next_state = S1;
                else
                    next_state = S;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S;
            end
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = DONE;
                else
                    next_state = S;
            end
            DONE: begin
                next_state = DONE;
            end
            default: begin
                next_state = S;
            end
        endcase
    end

    // State update
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= S;
        else 
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == DONE)
            start_shifting <= 1;
        else
            start_shifting <= 0;
    end

endmodule
