module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Definitions
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // Internal state variable
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
                out = 0;
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_C;
                end
                out = 0;
            end
            STATE_C: begin
                if (in) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_A;
                end
                out = 0;
            end
            STATE_D: begin
                if (in) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_C;
                end
                out = 1;
            end
            default: begin
                next_state = STATE_A;
                out = 0;
            end
        endcase
    end

endmodule
