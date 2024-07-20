module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

    // State definitions
    typedef enum reg [1:0] {
        S_IDLE = 2'b00,  // Initial state, waits for reset
        S_ONE = 2'b01,   // State after detecting a 1
        S_ZERO = 2'b10   // State after detecting a 0
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_IDLE;  // Reset state to idle
            z <= 1'b0;
        end else begin
            state <= next_state;  // Transition to next state
        end
    end

    always @(*) begin
        case (state)
            S_IDLE: begin
                if (!areset) begin
                    if (x == 1'b1) begin
                        next_state = S_ONE;
                        z = 1'b0;  // Output 1's complement of 1 -> 0
                    end else begin
                        next_state = S_ZERO;
                        z = 1'b1;  // Output 1's complement of 0 -> 1
                    end
                end else begin
                    next_state = S_IDLE;
                    z = 1'b0;
                end
            end

            S_ONE: begin
                if (x == 1'b1) begin
                    next_state = S_ONE;
                    z = 1'b0;  // Output 1's complement of 1 -> 0
                end else begin
                    next_state = S_ZERO;
                    z = 1'b1;  // Output 1's complement of 0 -> 1
                end
            end
            
            S_ZERO: begin
                if (x == 1'b1) begin
                    next_state = S_ONE;
                    z = 1'b1;  // Output 1's complement of 1 -> 1 with carry -> 0
                end else begin
                    next_state = S_ZERO;
                    z = 1'b0;  // Output 1's complement of 0 -> 1 with carry -> 0
                end
            end

            default: begin
                next_state = S_IDLE;
                z = 1'b0;
            end
        endcase
    end

endmodule
