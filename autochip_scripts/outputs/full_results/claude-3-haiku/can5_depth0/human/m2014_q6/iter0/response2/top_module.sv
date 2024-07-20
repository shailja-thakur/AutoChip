module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam [2:0] STATE_A = 3'd0,
                     STATE_B = 3'd1,
                     STATE_C = 3'd2,
                     STATE_D = 3'd3,
                     STATE_E = 3'd4,
                     STATE_F = 3'd5;

    reg [2:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (w) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (w) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                if (w) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_E;
                end
            end
            STATE_D: begin
                if (w) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_F;
                end
            end
            STATE_E: begin
                if (w) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_E;
                end
            end
            STATE_F: begin
                if (w) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(current_state) begin
        case (current_state)
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
