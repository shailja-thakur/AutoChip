module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State declaration
    typedef enum logic [2:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_t;

    // State variables
    state_t current_state, next_state;

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (current_state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w) next_state = S11;
                else next_state = S10;
            end
            C: begin
                if (w) next_state = S11;
                else next_state = S10;
            end
            S10: begin
                if (w) next_state = S21;
                else next_state = S20;
            end
            S11: begin
                if (w) next_state = S22;
                else next_state = S21;
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w) next_state = C;
                else next_state = B;
            end
            S22: begin
                if (w) next_state = B;
                else next_state = C;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
        end else begin
            case (current_state)
                S10, S11, S20, S21, S22: z <= 1;
                default: z <= 0;
            endcase
        end
    end

endmodule
