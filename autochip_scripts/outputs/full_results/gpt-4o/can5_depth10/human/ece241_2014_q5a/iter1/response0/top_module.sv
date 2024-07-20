module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg {
        S_IDLE = 1'b0,
        S_ONE = 1'b1
    } state_t;
    
    state_t state, next_state;

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S_IDLE: begin
                next_state = (x ? S_ONE : S_IDLE);
            end
            S_ONE: begin
                next_state = S_ONE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end else begin
            if (state == S_IDLE) begin
                z <= ~x; // Generate the 2's complement bit
            end else begin
                z <= ~x;
            end
        end
    end

endmodule
