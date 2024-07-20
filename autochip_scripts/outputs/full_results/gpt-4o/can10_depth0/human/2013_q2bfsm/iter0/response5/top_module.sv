module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'd0, // Beginning state
        STATE_B = 3'd1, // Set f to 1
        STATE_C = 3'd2, // Monitor x input
        STATE_D = 3'd3, // Set g to 1
        STATE_E = 3'd4, // Check y within two clock cycles
        STATE_F = 3'd5  // g remains 1 or 0 depending on y
    } state_t;
    
    state_t current_state, next_state;

    reg [1:0] x_seq; // To hold the sequence 1, 0, 1
    reg [1:0] y_check; // To hold the status of y check within two cycles

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_seq <= 2'b00;
            y_check <= 2'b00;
            f <= 0;
            g <= 0;
        end else begin
            current_state <= next_state;

            if (next_state == STATE_B) f <= 1;
            else f <= 0;

            case (next_state)
                STATE_E: y_check <= {y_check[0], y};
                default: y_check <= 2'b00;
            endcase
        end
    end

    always @(*) begin
        next_state = current_state;

        case (current_state)
            STATE_A: next_state = (resetn) ? STATE_B : STATE_A;
            STATE_B: next_state = STATE_C;
            STATE_C: begin
                x_seq = {x_seq[0], x};

                if (x_seq == 2'b11 && x == 0)
                    next_state = STATE_D;
                // Sequence complete to monitor y
                else
                    next_state = STATE_C;
            end
            STATE_D: next_state = STATE_E;
            STATE_E: begin
                if (y == 1) 
                    next_state = STATE_F;
                else if (y_check == 2'b01)
                    next_state = STATE_F;
                else
                    next_state = STATE_E;
            end
            STATE_F: next_state = STATE_F;
        endcase
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            g <= 0;
        else if (current_state == STATE_D)
            g <= 1;
        else if (current_state == STATE_E && y_check == 2'b01 && y != 1 && y == 0) 
            g <= 0;
    end

endmodule
