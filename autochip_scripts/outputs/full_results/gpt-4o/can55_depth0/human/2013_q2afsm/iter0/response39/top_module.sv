module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    state_t state, next_state;

    // State Flip-Flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // State Table
    always_comb begin
        next_state = state; // Default to the same state
        g = 3'b000; // Default to no grants
        case (state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
            end
            STATE_B: begin
                g[1] = 1;
                if (!r[1])
                    next_state = STATE_A;
            end
            STATE_C: begin
                g[2] = 1;
                if (!r[2])
                    next_state = STATE_A;
            end
            STATE_D: begin
                g[3] = 1;
                if (!r[3])
                    next_state = STATE_A;
            end
        endcase
    end

endmodule
