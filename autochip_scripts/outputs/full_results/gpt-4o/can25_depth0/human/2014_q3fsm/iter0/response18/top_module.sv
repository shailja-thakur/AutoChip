module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;
    logic [1:0] w_counter; // Counter to store the number of '1's in w during the three clock cycles

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (s == 1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                // Counting w-ones during three cycles
                next_state = STATE_C;
            end
            STATE_C: begin
                next_state = STATE_D;
            end
            STATE_D: begin
                next_state = STATE_B;
            end
        endcase
    end

    // State and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            w_counter <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                STATE_A: begin
                    w_counter <= 2'b00;
                    z <= 1'b0;
                end
                STATE_B: begin
                    if (w)
                        w_counter <= w_counter + 1;
                    z <= 1'b0;
                end
                STATE_C: begin
                    if (w)
                        w_counter <= w_counter + 1;
                    z <= 1'b0;
                end
                STATE_D: begin
                    if (w)
                        w_counter <= w_counter + 1;
                    if (w_counter == 2) 
                        z <= 1'b1;
                    else 
                        z <= 1'b0;
                    w_counter <= 2'b00; // Reset counter for the next three cycles
                end
            endcase
        end
    end

endmodule
