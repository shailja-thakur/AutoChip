module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S_INIT = 2'b00,
        S_FLIP = 2'b01,
        S_PASS = 2'b10
    } state_t;

    state_t state, next_state;

    // Sequential logic - state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_INIT;
        else
            state <= next_state;
    end

    // Combinational logic - next state logic
    always @(*) begin
        case (state)
            S_INIT: begin
                if (x == 1'b0)
                    next_state = S_INIT;
                else
                    next_state = S_FLIP;
            end
            S_FLIP: begin
                next_state = S_PASS;
            end
            S_PASS: begin
                next_state = S_PASS;
            end
            default: next_state = S_INIT;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else begin
            case (state)
                S_INIT: z <= ~x;
                S_FLIP: z <= ~x;
                S_PASS: z <= x;
                default: z <= x;
            endcase
        end
    end

endmodule
