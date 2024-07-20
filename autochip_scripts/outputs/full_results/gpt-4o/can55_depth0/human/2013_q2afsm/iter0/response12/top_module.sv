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

    state_t state, next_state;

    // State flip-flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // State table
    always_comb begin
        next_state = state;
        g = 3'b000; // Default: no grant signals
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
            end
            B: begin
                g[1] = 1;
                if (!r[1])
                    next_state = A;
            end
            C: begin
                g[2] = 1;
                if (!r[2])
                    next_state = A;
            end
            D: begin
                g[3] = 1;
                if (!r[3])
                    next_state = A;
            end
        endcase
    end

endmodule
