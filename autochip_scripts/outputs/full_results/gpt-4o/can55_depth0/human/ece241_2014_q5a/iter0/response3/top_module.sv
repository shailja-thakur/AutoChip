module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        STATE_IDLE = 2'b00,
        STATE_COPY = 2'b01,
        STATE_COMPLEMENT = 2'b10,
        STATE_OUTPUT = 2'b11
    } state_t;

    state_t state, next_state;
    reg complement;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_IDLE: begin
                if (!areset) begin
                    next_state = STATE_COPY;
                end else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_COPY: begin
                if (x == 1'b0) begin
                    next_state = STATE_COPY;
                end else begin
                    next_state = STATE_COMPLEMENT;
                end
            end
            STATE_COMPLEMENT: begin
                next_state = STATE_OUTPUT;
            end
            STATE_OUTPUT: begin
                next_state = STATE_COPY;
            end
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    always @(*) begin
        case (state)
            STATE_IDLE: begin
                z = 1'b0;
                complement = 1'b0;
            end
            STATE_COPY: begin
                z = x;
                complement = (x == 1'b1) ? 1'b1 : complement;
            end
            STATE_COMPLEMENT: begin
                z = ~x;
            end
            STATE_OUTPUT: begin
                z = complement;
            end
            default: begin
                z = 1'b0;
            end
        endcase
    end

endmodule
