module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {S_A = 2'b00, S_B = 2'b01, S_C = 2'b10, S_D = 2'b11} state_t;
    state_t state, next_state;

    // State flip-flops (sequential logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S_A; // Reset to state A
        else
            state <= next_state; // Move to the next state
    end

    // Next state logic (combinational logic)
    always @(*) begin
        // Defaults
        next_state = state; 
        case (state)
            S_A: begin
                if (r[1])
                    next_state = S_B; // Device 1 has highest priority
                else if (r[2])
                    next_state = S_C; // Device 2 has second priority
                else if (r[3])
                    next_state = S_D; // Device 3 has lowest priority
                else
                    next_state = S_A; // No request
            end
            S_B: begin
                if (r[1])
                    next_state = S_B; // Stay in state B as long as r1 is active
                else
                    next_state = S_A; // Otherwise, go back to state A
            end
            S_C: begin
                if (r[2])
                    next_state = S_C; // Stay in state C as long as r2 is active
                else
                    next_state = S_A; // Otherwise, go back to state A
            end
            S_D: begin
                if (r[3])
                    next_state = S_D; // Stay in state D as long as r3 is active
                else
                    next_state = S_A; // Otherwise, go back to state A
            end
            default: next_state = S_A; // Default case
        endcase
    end

    // Output logic (combinational logic)
    always @(*) begin
        // Defaults
        g = 3'b000;
        case (state)
            S_B: g[1] = 1'b1; // Grant to device 1
            S_C: g[2] = 1'b1; // Grant to device 2
            S_D: g[3] = 1'b1; // Grant to device 3
            default: g = 3'b000; // No grants
        endcase
    end

endmodule
