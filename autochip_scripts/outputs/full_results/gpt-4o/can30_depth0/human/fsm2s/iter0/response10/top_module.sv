module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 1'b0,
        ON = 1'b1
    } state_t;

    state_t state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
            OFF: begin
                out = 1'b0;
                next_state = j ? ON : OFF;
            end
            ON: begin
                out = 1'b1;
                next_state = k ? OFF : ON;
            end
            default: begin
                next_state = OFF;
            end
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

endmodule
