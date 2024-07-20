module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg [0:0] {
        B = 1'b0,
        A = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            current_state <= B;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1;
        else
            out <= (current_state == B);
    end

endmodule
