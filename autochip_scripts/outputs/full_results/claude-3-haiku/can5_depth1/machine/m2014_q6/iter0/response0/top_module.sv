module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

typedef enum reg [2:0] {
    STATE_A, STATE_B, STATE_C, STATE_D, STATE_E, STATE_F
} state_t;

state_t current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (w) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_E;
            end
        end
        STATE_D: begin
            if (w) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_F;
            end
        end
        STATE_E: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_E;
            end
        end
        STATE_F: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

always @(*) begin
    case (current_state)
        STATE_E, STATE_F: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
