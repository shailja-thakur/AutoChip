module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // States
    typedef enum logic [0:0] {B = 1'b0, A = 1'b1} state_t;
    state_t state, next_state;

    // State transition logic (sequential)
    always_ff @(posedge clk) begin
        if (reset)
            state <= B; // reset state
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        case (state)
            B: next_state = in ? B : A;
            A: next_state = in ? A : B;
            default: next_state = B;
        endcase
    end

    // Output logic (combinational)
    always_ff @(posedge clk) begin
        if (reset)
            out <= 1;
        else begin
            case (state)
                B: out <= 1;
                A: out <= 0;
                default: out <= 1;
            endcase
        end
    end
endmodule
