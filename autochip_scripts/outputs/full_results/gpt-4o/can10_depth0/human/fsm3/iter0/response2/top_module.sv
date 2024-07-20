module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A, B, C: out = 1'b0;
            D:       out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

endmodule
