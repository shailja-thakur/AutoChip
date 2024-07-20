module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B; // Reset to state B
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 1'b1; // State B, output high
        end else begin
            case (current_state)
                A: out <= 1'b0;
                B: out <= 1'b1;
            endcase
        end
    end

endmodule
