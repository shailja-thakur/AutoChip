module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define state encoding
    typedef enum logic [0:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic (Combinational)
    always @(*) begin
        case (current_state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // Default to state A
        endcase
    end

    // State flip-flops with synchronous reset (Sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A; // Initialize to state A
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
