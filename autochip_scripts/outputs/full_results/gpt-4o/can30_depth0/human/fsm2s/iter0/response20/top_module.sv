module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: next_state = (j == 1'b1) ? ON : OFF;
            ON : next_state = (k == 1'b1) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            out <= (state == ON) ? 1'b1 : 1'b0;
        end
    end

endmodule
