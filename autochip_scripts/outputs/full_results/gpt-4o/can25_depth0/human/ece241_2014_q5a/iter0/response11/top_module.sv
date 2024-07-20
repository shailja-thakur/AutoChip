module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding
    typedef enum reg [1:0] {
        S_START,
        S_ZEROS,
        S_ONES
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_START;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_START: begin
                if (x == 1'b1) begin
                    next_state = S_ONES;
                end else begin
                    next_state = S_ZEROS;
                end
            end
            S_ZEROS: begin
                if (x == 1'b1) begin
                    next_state = S_ONES;
                end else begin
                    next_state = S_ZEROS;
                end
            end
            S_ONES: begin
                if (x == 1'b0) begin
                    next_state = S_ONES;
                end else begin
                    next_state = S_ZEROS;
                end
            end
            default: next_state = S_START;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S_START: z = 0;
            S_ZEROS: z = ~x;
            S_ONES: z = x;
            default: z = 0;
        endcase
    end

endmodule
