module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        ZERO = 2'b00,    // State before inversion started
        INVERT = 2'b01   // State during inversion
    } state_t;

    reg state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= ZERO;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            ZERO: begin
                if (x) begin
                    next_state = INVERT;
                    z = 1;
                end else begin
                    next_state = ZERO;
                    z = 0;
                end
            end
            INVERT: begin
                if (x) begin
                    next_state = INVERT;
                    z = 0;
                end else begin
                    next_state = INVERT;
                    z = 1;
                end
            end
            default: begin
                next_state = ZERO;
                z = 0;
            end
        endcase
    end
endmodule
