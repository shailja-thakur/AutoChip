module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State definitions
    typedef enum logic {
        A = 1'b0, // State A
        B = 1'b1  // State B
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= B; // Reset state
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        case (current_state)
            B: begin
                if (in == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
                out = 1'b1;
            end
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                out = 1'b0;
            end
            default: begin
                next_state = B; // Default state
                out = 1'b1;
            end
        endcase
    end

endmodule
