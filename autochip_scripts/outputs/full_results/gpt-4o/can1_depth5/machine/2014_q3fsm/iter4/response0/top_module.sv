module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {
        A    = 3'd0,
        B    = 3'd1,
        C    = 3'd2,
        S10  = 3'd3,
        S11  = 3'd4,
        S20  = 3'd5,
        S21  = 3'd6,
        S22  = 3'd7
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A:
                if (s)
                    next_state = B;
                else
                    next_state = A;
            B:
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            C:
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            S10:
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            S11:
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            S20:
                next_state = B;
            S21:
                if (w)
                    next_state = C;
                else
                    next_state = B;
            S22:
                if (w)
                    next_state = B;
                else
                    next_state = C;
            default:
                next_state = A; // Default state
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else
            z <= (current_state == S11 || current_state == S21 || current_state == S22);
    end

endmodule
