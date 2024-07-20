module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B; // Active high asynchronous reset to state B
        end
        else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (current_state)
            A: if (in)
                next_state = A;
               else
                next_state = B;
            B: if (in)
                next_state = B;
               else
                next_state = A;
            default: next_state = B;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end
endmodule
