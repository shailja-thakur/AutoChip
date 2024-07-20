module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    typedef enum logic[1:0] {
        S_IDLE = 2'b00,
        S_ONES = 2'b01,
        S_COMP = 2'b10
    } state_t;

    state_t state, next_state;
    reg flip;  // flag to indicate flipping needs to start

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = state;  // Default to remain in current state.
        z = 1'b0;            // Default output.

        case (state)
            S_IDLE: begin
                if (!areset) begin
                    next_state = S_ONES;
                    z = ~x;  // Start by flipping the first bit.
                    flip = x ? 0 : 1;  // If first bit is 1, no immediate flip needed.
                end
            end

            S_ONES: begin
                if (areset) begin
                    next_state = S_IDLE;
                end else if (flip) begin
                    z = x;  // Pass through during inversion
                    if (x == 0) begin
                        next_state = S_COMP;  // Transition to complement state if 0 found.
                        flip = 0;
                    end
                end else begin
                    z = ~x;  // Continue flipping until first 1 is found.
                    if (x == 1) begin
                        flip = 1;
                    end
                end
            end

            S_COMP: begin
                if (areset) begin
                    next_state = S_IDLE;
                end else begin
                    z = x;  // No flipping, just pass through.
                end
            end

            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule
