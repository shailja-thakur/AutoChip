module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_B1 = 2'b10,
        STATE_B2 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] w_counter; // to count number of ones in three clock cycles in state B

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            w_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B2) begin
                if (w_counter == 2)
                    z <= 1'b1;
                else
                    z <= 1'b0;
                w_counter <= 0; // Reset counter for next three-clock cycle evaluation
            end else if (current_state == STATE_B1 || current_state == STATE_B) begin
                w_counter <= w_counter + w; // Update counter
            end else if (current_state == STATE_A) begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                next_state = STATE_B1;
            end
            STATE_B1: begin
                next_state = STATE_B2;
            end
            STATE_B2: begin
                next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
