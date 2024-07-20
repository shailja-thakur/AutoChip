module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    int count;  // To count occurrences of w = 1

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic and counting logic
    always @(*) begin
        next_state = state;  // Default state transition
        z = 0;  // Default output value
        case (state)
            A: begin
                if (s) next_state = B;
            end
            B: begin
                if (reset) count = 0;  // Reset count to zero
                next_state = C;
            end
            C: begin
                if (w) count = count + 1;
                next_state = D;
            end
            D: begin
                if (w) count = count + 1;
                if (count == 2) z = 1;
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Synchronous reset of count variable
    always @(posedge clk) begin
        if (reset || state == C)
            count <= 0;
    end
endmodule
