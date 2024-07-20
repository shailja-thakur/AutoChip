module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State Flip-Flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // State Table (Next State Logic)
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
                if (r[1])
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[2])
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                // If in state D, return to A (optional, no explicit transition)
                next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (state)
            STATE_A: g = 3'b000;
            STATE_B: g = 3'b001;
            STATE_C: g = 3'b010;
            STATE_D: g = 3'b100;  // Assuming g[3] needs to be asserted if state is specific to r[3]
            default: g = 3'b000;
        endcase
    end

endmodule
