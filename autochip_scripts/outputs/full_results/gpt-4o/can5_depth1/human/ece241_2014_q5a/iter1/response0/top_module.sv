module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        ZERO        = 2'd0,  // Initially zero state
        ONE         = 2'd1,  // Encounters first one 
        COMPLEMENT  = 2'd2   // Start complementing
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) 
            state <= ZERO;
        else
            state <= next_state;
    end

    always_comb begin
        case (state)
            ZERO: begin
                z = x;
                if (x == 1)
                    next_state = ONE;
                else
                    next_state = ZERO;
            end
            ONE: begin
                z = 1;
                next_state = COMPLEMENT;
            end
            COMPLEMENT: begin
                z = ~x;
                next_state = COMPLEMENT;
            end
            default: begin
                z = x;
                next_state = ZERO;
            end
        endcase
    end

endmodule
