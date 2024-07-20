module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic (next-state logic)
    always @(*) begin
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
                next_state = STATE_A;
            end
            default: next_state = STATE_A; // For safety
        endcase
    end

    // State flip-flops (state register)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default all grants to 0
        case (state)
            STATE_B: g[1] = 1;
            STATE_C: g[2] = 1;
            STATE_D: g[3] = 1;
        endcase
    end

endmodule
