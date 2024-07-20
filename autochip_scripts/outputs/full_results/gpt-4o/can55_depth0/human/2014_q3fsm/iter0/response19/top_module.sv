module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // States
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;
    reg [1:0] w_count;  // To count the number of 1's in w during three cycles
    reg [1:0] cycle_count;  // To count the number of cycles in state B

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'd0;
            cycle_count <= 2'd0;
            z <= 0;
        end
        else begin
            current_state <= next_state;
            if(current_state == STATE_B) begin
                cycle_count <= cycle_count + 1;
            end
            else begin
                cycle_count <= 2'd0;
            end

            if(current_state == STATE_B && cycle_count < 3) begin
                if (w) begin
                    w_count <= w_count + 1;
                end
            end
            else if(current_state == STATE_B && cycle_count == 3) begin
                if (w_count == 2) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                w_count <= 2'd0;  // Reset the count after 3 cycles in state B
            end
            else begin
                w_count <= 2'd0;
                z <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end

            STATE_B: begin
                if (cycle_count == 3) begin
                    next_state = STATE_B;  // Continue in STATE_B to keep checking w
                end else begin
                    next_state = STATE_B;  // Stay in same state to continue checking w
                end
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
