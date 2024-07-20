module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State registers
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // State transition logic
    always_comb begin
        case (current_state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A; // No requests, stay in state A
            end
            B: begin
                if (r[1])
                    next_state = B; // Stay in state B if r1 is still high
                else
                    next_state = A; // Go back to state A otherwise
            end
            C: begin
                if (r[2])
                    next_state = C; // Stay in state C if r2 is still high
                else
                    next_state = A; // Go back to state A otherwise
            end
            D: begin
                next_state = A; // Always go back to state A from state D
            end
            default: next_state = A; // Default state
        endcase
    end

    // Output logic
    always_comb begin
        g = 3'b000; // Default value
        case (current_state)
            B: g[1] = 1'b1; // Grant signal for state B
            C: g[2] = 1'b1; // Grant signal for state C
            D: g[3] = 1'b1; // Grant signal for state D
        endcase
    end
endmodule
