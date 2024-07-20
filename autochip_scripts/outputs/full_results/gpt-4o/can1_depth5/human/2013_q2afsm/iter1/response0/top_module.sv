module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum logic [1:0] {S_A = 2'b00, S_B = 2'b01, S_C = 2'b10, S_D = 2'b11} state_t;
    state_t state, next_state;

    // State Flip-Flops (State Register)
    always @(posedge clk) begin
        if (!resetn)
            state <= S_A; // Reset to State A
        else
            state <= next_state;
    end

    // Next State Logic (State Table)
    always @(*) begin
        next_state = state; // Default state remains the same
        case (state)
            S_A: begin
                if (r[1]) next_state = S_B;               // r1 has highest priority
                else if (r[2]) next_state = S_C;          // r2 has middle priority
                else if (r[3]) next_state = S_D;          // r3 has lowest priority
            end
            S_B: begin
                if (!r[1]) next_state = S_A;              // Go back to A if r1 is de-asserted
            end
            S_C: begin
                if (!r[2]) next_state = S_A;              // Go back to A if r2 is de-asserted
            end
            S_D: begin
                if (!r[3]) next_state = S_A;              // Go back to A if r3 is de-asserted
            end
        endcase
    end

    // Output Logic
    always @(*) begin
        g = 3'b000; // Default all grants are off
        case (state)
            S_B: g[1] = 1;    // Grant for Device 1
            S_C: g[2] = 1;    // Grant for Device 2
            S_D: g[3] = 1;    // Grant for Device 3
        endcase
    end

endmodule
