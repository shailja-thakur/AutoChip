module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            S: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
            end
            default: next_state = S;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            S: z = 0;
            S1: z = 0;
            S10: z = x;
            default: z = 0;
        endcase
    end

endmodule
