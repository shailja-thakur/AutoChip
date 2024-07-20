module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
