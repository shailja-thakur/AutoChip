module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define states
    typedef enum logic [1:0] {
        A = 1'b0,
        B = 1'b1
    } state_t;

    // State register
    state_t state, next_state;

    // Combinational logic to determine next state
    always_comb begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end

    // Sequential logic to update state register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always_comb begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
