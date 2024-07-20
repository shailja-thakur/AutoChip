module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    typedef enum logic [1:0] {
        S_INIT = 2'b00,
        S_SEEN_ONE = 2'b01,
        S_FLIPPED = 2'b10
    } state_t;
    
    state_t state, next_state;
    logic z_reg;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_INIT;
            z_reg <= 0;
        end else begin
            state <= next_state;

            case (state)
                S_INIT: z_reg <= x;
                S_SEEN_ONE,
                S_FLIPPED: z_reg <= ~x;
            endcase
        end
    end

    always_comb begin
        case (state)
            S_INIT: next_state = x ? S_SEEN_ONE : S_INIT;
            S_SEEN_ONE: next_state = S_FLIPPED;
            S_FLIPPED: next_state = S_FLIPPED;
        endcase
    end

    assign z = z_reg;

endmodule
