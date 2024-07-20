module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            A: next_state = in ? state_t'B : state_t'A;
            B: next_state = in ? state_t'B : state_t'C;
            C: next_state = in ? state_t'D : state_t'A;
            D: next_state = in ? state_t'B : state_t'C;
            default: next_state = state_t'A;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= state_t'A;
        else
            current_state <= next_state;
    end

    // Output logic
    assign out = (current_state == state_t'D);

endmodule
