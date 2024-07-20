module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        S,       // 0
        S1,      // 1
        S11,     // 2
        S110,    // 3
        Done     // 4
    } state_t;
    state_t state, next_state;

    // State transition logic (combinational logic block)
    always_comb begin
        case (state)
            S: 
                if (data)
                    next_state = S1;
                else
                    next_state = S;
            S1:
                if (data)
                    next_state = S11;
                else
                    next_state = S;
            S11:
                if (data)
                    next_state = S11; // remains in S11
                else
                    next_state = S110;
            S110:
                if (data)
                    next_state = Done;
                else
                    next_state = S;
            Done:
                next_state = Done;
            default:
                next_state = S;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic
    always_comb begin
        if (state == Done)
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
