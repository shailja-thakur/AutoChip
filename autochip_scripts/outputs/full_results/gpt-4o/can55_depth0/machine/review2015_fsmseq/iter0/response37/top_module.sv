module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State declaration
    typedef enum logic [2:0] {S, S1, S11, S110, Done} state_t;
    state_t current_state, next_state;

    // State register logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S;
        else
            current_state <= next_state;
    end

    // Next state logic
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
                    next_state = Done;
                else
                    next_state = S;
            end
            Done: begin
                next_state = Done;
            end
            default: next_state = S;  // Default state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == Done)
            start_shifting <= 1;
        else
            start_shifting <= 0;
    end

endmodule
