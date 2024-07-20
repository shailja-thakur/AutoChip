module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State Transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset to state B
        end else begin
            state <= next_state;
        end
    end

    // Output Logic and Next State Logic
    always @(*) begin
        case (state)
            B: begin
                out = 1'b1;
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            A: begin
                out = 1'b0;
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: begin
                out = 1'b1;
                next_state = B; // Default to state B
            end
        endcase
    end

endmodule
