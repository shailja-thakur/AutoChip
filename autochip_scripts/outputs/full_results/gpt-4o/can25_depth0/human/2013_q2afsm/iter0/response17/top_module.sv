module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'd0,
        STATE_B = 2'd1,
        STATE_C = 2'd2,
        STATE_D = 2'd3
    } state_t;

    state_t state, next_state;

    // State flip-flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // State table / next state logic
    always_comb begin
        case (state)
            STATE_A: begin
                if (r[1]) 
                    next_state = STATE_B;
                else if (r[2] && !r[1]) 
                    next_state = STATE_C;
                else if (r[3] && !r[1] && !r[2])
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
                next_state = STATE_A; // As per given diagram, no transition from D is specified
            end

            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_comb begin
        g = 3'd0; // Default all grants to 0
        case (state)
            STATE_B: g[1] = 1'd1;
            STATE_C: g[2] = 1'd1;
            STATE_D: g[3] = 1'd1;
            default: g = 3'd0;
        endcase
    end

endmodule
