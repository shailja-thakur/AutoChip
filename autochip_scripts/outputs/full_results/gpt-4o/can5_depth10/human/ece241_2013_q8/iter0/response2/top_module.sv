module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S0, // Initial state or after detecting "101"
        S1, // State after detecting "1"
        S2  // State after detecting "10"
    } state_t;

    state_t state, next_state;

    // State transition logic (Mealy FSM)
    always @(*) begin
        z = 0;
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;  // Detect '1'
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S2;  // Detect '10'
                end
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1;  // Detect '101'
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end

    // State register and asynchronous reset
    always @(negedge aresetn or posedge clk) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

endmodule
