module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define states
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        case (state)
            A: if (j) next_state = B;
               else next_state = A;
            B: if (k) next_state = A;
               else next_state = B;
            default: next_state = A;
        endcase
    end

    // Output Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            case (state)
                A: out <= 1'b0;
                B: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end

endmodule
