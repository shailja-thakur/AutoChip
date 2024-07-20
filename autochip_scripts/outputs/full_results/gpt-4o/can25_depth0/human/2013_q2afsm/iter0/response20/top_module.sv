module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01, // g1=1
        C = 2'b10, // g2=1
        D = 2'b11  // No device granted
    } state_t;

    state_t state, next_state;

    // State flip-flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State transitions (state table)
    always_comb begin
        next_state = state;
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            B: begin
                if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end
            C: begin
                if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end
            D: begin
                if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // Outputs
    always_comb begin
        g[1] = (state == B);
        g[2] = (state == C);
        g[3] = (state == D);
    end

endmodule
