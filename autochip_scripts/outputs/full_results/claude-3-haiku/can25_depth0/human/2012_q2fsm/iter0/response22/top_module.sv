module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State encoding
    localparam STATE_A = 3'd0;
    localparam STATE_B = 3'd1;
    localparam STATE_C = 3'd2;
    localparam STATE_D = 3'd3;
    localparam STATE_E = 3'd4;
    localparam STATE_F = 3'd5;

    // State registers
    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (w)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (w)
                    next_state = STATE_C;
                else
                    next_state = STATE_D;
            end
            STATE_C: begin
                if (w)
                    next_state = STATE_E;
                else
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (w)
                    next_state = STATE_F;
                else
                    next_state = STATE_A;
            end
            STATE_E: begin
                if (w)
                    next_state = STATE_E;
                else
                    next_state = STATE_D;
            end
            STATE_F: begin
                if (w)
                    next_state = STATE_C;
                else
                    next_state = STATE_D;
            end
            default:
                next_state = STATE_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    assign z = (current_state == STATE_E) || (current_state == STATE_F);

endmodule
