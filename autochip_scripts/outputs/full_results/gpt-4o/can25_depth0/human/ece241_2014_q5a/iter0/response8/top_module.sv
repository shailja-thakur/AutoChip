module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S_IDLE = 2'b00,
        S_INVERT = 2'b01,
        S_PASS = 2'b10
    } state_t;

    state_t state, next_state;
    reg carry;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_IDLE;
            carry <= 0;
        end else begin
            state <= next_state;
            if (state == S_INVERT)
                carry <= 1'b1;
            else if (state == S_PASS)
                carry <= carry;
            else
                carry <= 0;
        end
    end

    always @* begin
        case (state)
            S_IDLE: next_state = (areset == 1'b0) ? S_INVERT : S_IDLE;
            S_INVERT:
                if (x == 1'b1)
                    next_state = S_PASS;
                else
                    next_state = S_INVERT;
            S_PASS: next_state = S_PASS;
            default: next_state = S_IDLE;
        endcase
    end

    always @* begin
        case (state)
            S_IDLE: z = 0;
            S_INVERT: z = ~x;
            S_PASS: z = carry ? 1'b1 : x;
            default: z = 0;
        endcase
    end

endmodule
