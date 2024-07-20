module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B;
        endcase
    end

    // State Register with Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;        // Asynchronously reset to state B
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
