module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        S = 3'd0,
        S1 = 3'd1,
        S11 = 3'd2,
        S110 = 3'd3,
        DONE = 3'd4
    } state_t;

    state_t state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
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

    // Output logic
    assign start_shifting = (state == DONE);

endmodule
