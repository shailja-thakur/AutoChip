module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        STATE_IDLE = 2'b00,
        STATE_FLIP = 2'b01,
        STATE_PASS = 2'b10
    } state_t;

    state_t state, next_state;

    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            STATE_IDLE: begin
                if (!x) begin
                    next_state = STATE_IDLE;
                    z = x;
                end else begin
                    next_state = STATE_FLIP;
                    z = ~x;
                end
            end
            STATE_FLIP: begin
                next_state = STATE_PASS;
                z = x;
            end
            STATE_PASS: begin
                next_state = STATE_PASS;
                z = x;
            end
            default: begin
                next_state = STATE_IDLE;
                z = x;
            end
        endcase
    end
endmodule
