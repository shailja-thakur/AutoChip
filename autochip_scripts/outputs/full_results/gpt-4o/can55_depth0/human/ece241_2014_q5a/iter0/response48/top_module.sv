module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        INVERT = 2'b01,
        PASS = 2'b10
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            z <= 0;
        else
            case (state)
                IDLE: z <= 0;
                INVERT: z <= ~x;
                PASS: z <= x;
            endcase
    end
    
    always_comb begin
        case (state)
            IDLE: if (!areset) next_state = INVERT; else next_state = IDLE;
            INVERT: next_state = PASS;
            PASS: next_state = PASS;
            default: next_state = IDLE;
        endcase
    end

endmodule
