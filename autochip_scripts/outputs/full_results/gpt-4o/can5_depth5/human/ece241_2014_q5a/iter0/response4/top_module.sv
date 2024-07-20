module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {S0, S1} state_t;
    state_t state, next_state;

    // State transition
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @* begin
        case (state)
            S0: begin
                if (x == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                next_state = S1;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @* begin
        case (state)
            S0: z = x;
            S1: z = ~x;
            default: z = x;
        endcase
    end

endmodule
