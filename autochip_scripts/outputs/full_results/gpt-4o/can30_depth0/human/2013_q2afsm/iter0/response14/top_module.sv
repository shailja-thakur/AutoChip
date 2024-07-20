module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011
    } state_t;
    
    state_t state, next_state;

    // State flip-flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic (State Table)
    always_comb begin
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

    // Output logic (grants)
    always_comb begin
        case (state)
            B: begin
                g[1] = 1;
                g[2] = 0;
                g[3] = 0;
            end
            C: begin
                g[1] = 0;
                g[2] = 1;
                g[3] = 0;
            end
            D: begin
                g[1] = 0;
                g[2] = 0;
                g[3] = 1;
            end
            default: begin
                g[1] = 0;
                g[2] = 0;
                g[3] = 0;
            end
        endcase
    end

endmodule
