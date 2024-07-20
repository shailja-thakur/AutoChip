module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // Define State Codes
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
   
    state_t state, next_state;

    // State Flip-Flop
    always @(posedge clk) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // State Table
    always @(*) begin
        next_state = state;  // Default to stay in the same state
        case (state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (!r[1])
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_C: begin
                if (!r[2])
                    next_state = STATE_A;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (!r[3])
                    next_state = STATE_A;
                else
                    next_state = STATE_D;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output Logic
    always @(*) begin
        g = 3'b000; // Default: No grants
        case (state)
            STATE_B: g[1] = 1;
            STATE_C: g[2] = 1;
            STATE_D: g[3] = 1;
            default: g = 3'b000;
        endcase
    end

endmodule
