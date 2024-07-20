module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        ZERO = 2'b00,
        COMPLEMENT = 2'b01,
        PASSTHROUGH = 2'b10
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= ZERO;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            ZERO: begin
                if (x) begin
                    next_state = COMPLEMENT;
                    z = 1;
                end else begin
                    next_state = ZERO;
                    z = 0;
                end
            end
            COMPLEMENT: begin
                if (x) begin
                    next_state = COMPLEMENT;
                    z = 0;
                end else begin
                    next_state = PASSTHROUGH;
                    z = 1;
                end
            end
            PASSTHROUGH: begin
                next_state = PASSTHROUGH;
                z = x;
            end
            default: begin
                next_state = ZERO;
                z = 0;
            end
        endcase
    end
endmodule
