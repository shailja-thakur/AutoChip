module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {STATE_INIT, STATE_FLIP, STATE_PASS} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_INIT;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            STATE_INIT: begin
                if (x == 1)
                    next_state = STATE_FLIP;
                else
                    next_state = STATE_PASS;
                z = x; // Initial state, output is same as input
            end
            STATE_FLIP: begin
                z = ~x; // Flip the incoming bit for 2's complement
                next_state = STATE_FLIP; // Stay in FLIP state for inversion
            end        
            STATE_PASS: begin
                z = x; // Pass the bit directly
                next_state = STATE_PASS;
            end
            default: begin
                next_state = STATE_INIT;
                z = x;
            end
        endcase
    end

endmodule
