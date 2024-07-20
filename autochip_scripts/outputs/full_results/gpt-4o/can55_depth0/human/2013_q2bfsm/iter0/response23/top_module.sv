module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
   
    state_t current_state, next_state;
    reg [1:0] y_counter;

    // Output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;

            // FSM output logic
            case (current_state)
                STATE_B: f <= 1'b1;
                default: f <= 1'b0;
            endcase
            if (current_state == STATE_D) g <= 1'b1;
            else if (current_state == STATE_F) g <= 1'b0;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: if (!resetn) next_state = STATE_A;
                     else next_state = STATE_B;

            STATE_B: next_state = STATE_C;
                     f = 1'b1; // Set f to 1 for one clock cycle

            STATE_C: if (x == 1'b1) next_state = STATE_D;

            STATE_D: if (x == 1'b0) next_state = STATE_E;

            STATE_E: if (x == 1'b1) next_state = STATE_F;

            STATE_F: begin
                        if (y == 1'b1) begin
                            g = 1'b1;
                            y_counter = 2'b00;
                        end else if (y_counter == 2'b10) begin
                            g = 1'b0;
                            y_counter = 2'b00;
                        end else begin
                            y_counter = y_counter + 1;
                        end
                     end

            default: next_state = STATE_A;
        endcase
    end  
endmodule
