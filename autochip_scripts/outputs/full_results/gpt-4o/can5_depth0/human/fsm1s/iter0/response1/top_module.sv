module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic (combinatorial)
    always @(*) begin
        case (state) 
            B: next_state = in ? B : A;
            A: next_state = in ? A : B;
            default: next_state = B;
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic (combinatorial)
    always @(*) begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // Default to state B if unexpected
        endcase
    end
endmodule
