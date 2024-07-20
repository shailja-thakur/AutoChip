module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {
        S_A = 2'd0,
        S_B = 2'd1,
        S_C = 2'd2,
        S_D = 2'd3
    } state_t;

    state_t state, next_state;

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S_A;
        else
            state <= next_state;
    end

    // State table (next state logic)
    always @(*) begin
        case (state)
            S_A: begin
                if (r[1])
                    next_state = S_B;
                else if (r[2])
                    next_state = S_C;
                else if (r[3])
                    next_state = S_D;
                else
                    next_state = S_A;
            end
            S_B: begin
                if (r[1])
                    next_state = S_B;
                else
                    next_state = S_A;
            end
            S_C: begin
                if (r[2])
                    next_state = S_C;
                else
                    next_state = S_A;
            end
            S_D: begin
                // No transitions from state D are provided in the description,
                // Assuming it transitions back to state A when all requests are 0.
                if (!r[1] && !r[2] && !r[3])
                    next_state = S_A;
                else
                    next_state = S_D;
            end
            default: next_state = S_A;
        endcase
    end

    // Output logic (current state outputs)
    always @(*) begin
        case (state)
            S_A: g = 3'b000;
            S_B: g = 3'b001;
            S_C: g = 3'b010;
            S_D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end

endmodule
