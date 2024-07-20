module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
    );

    // State declarations
    typedef enum logic [2:0] {
        S    = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        Done = 3'b100
    } state_t;

    // State register
    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            S:    next_state = data ? S1   : S;
            S1:   next_state = data ? S11  : S;
            S11:  next_state = data ? S11  : S110;
            S110: next_state = data ? Done : S;
            Done: next_state = Done;
            default: next_state = S;
        endcase
    end

    // State register update (sequential)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 1'b0;
        else
            start_shifting <= (state == Done);
    end
endmodule
