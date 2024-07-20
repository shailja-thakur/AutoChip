module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg {
        S_IDLE = 1'b0,
        S_GEN   = 1'b1
    } state_t;

    reg state, next_state;
    reg flip; // flip-flop to keep track of whether we've encountered a 1

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (areset)
                    next_state = S_IDLE;
                else
                    next_state = S_GEN;
            end
            S_GEN: begin
                if (areset)
                    next_state = S_IDLE;
                else
                    next_state = S_GEN;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output and flip logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            flip <= 0;
        end else if (state == S_GEN) begin
            if (flip)
                z <= ~x;
            else
                z <= x;
            if (x)
                flip <= 1;
        end
    end

endmodule
