module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        STATE_WAIT = 2'b00,
        STATE_ONE = 2'b01,
        STATE_COMPLEMENT = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg complement_bit;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_WAIT;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_WAIT: begin
                if (x == 1'b1)
                    next_state = STATE_ONE;
                else
                    next_state = STATE_WAIT;
            end
            STATE_ONE: begin
                next_state = STATE_COMPLEMENT;
            end
            STATE_COMPLEMENT: begin
                next_state = STATE_COMPLEMENT;
            end
            default: begin
                next_state = STATE_WAIT;
            end
        endcase
    end

    // Output logic and Moore FSM behavior
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            complement_bit <= 1'b0;
            z <= 1'b0;
        end else begin
            case (state)
                STATE_WAIT: begin
                    z <= x;
                end
                STATE_ONE: begin
                    z <= ~x;
                    complement_bit <= 1'b1;
                end
                STATE_COMPLEMENT: begin
                    z <= x ^ complement_bit;
                end
                default: begin
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule
