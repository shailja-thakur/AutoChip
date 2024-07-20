module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 2'd0;
            cycle_count <= 2'd0;
            z <= 1'b0;
        end else begin
            state <= next_state;

            if (state == STATE_B) begin
                cycle_count <= cycle_count + 1;

                if (w)
                    w_count <= w_count + 1;

                if (cycle_count == 3) begin
                    if (w_count == 2)
                        z <= 1'b1;
                    else
                        z <= 1'b0;

                    // Reset counts after 3 cycles
                    w_count <= 2'd0;
                    cycle_count <= 2'd0;
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (cycle_count == 3)
                    next_state = STATE_B;
                else
                    next_state = STATE_B;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
