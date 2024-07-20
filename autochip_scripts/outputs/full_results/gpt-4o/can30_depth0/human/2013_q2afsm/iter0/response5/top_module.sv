module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State codes
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition (state flip-flops)
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // State table (transition logic)
    always_comb begin
        next_state = state;
        case(state)
            STATE_A: begin
                if (r[1] == 1'b1)
                    next_state = STATE_B;
                else if (r[2] == 1'b1)
                    next_state = STATE_C;
                else if (r[3] == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[1] == 1'b1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[2] == 1'b1)
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_comb begin
        g = 3'b000; // Default no grants
        case(state)
            STATE_A: begin
                // No grants in state A
            end
            STATE_B: begin
                g[1] = 1'b1; // Grant to device 1
            end
            STATE_C: begin
                g[2] = 1'b1; // Grant to device 2
            end
            STATE_D: begin
                g[3] = 1'b1; // Grant to device 3
            end
            default: g = 3'b000;
        endcase
    end

endmodule
