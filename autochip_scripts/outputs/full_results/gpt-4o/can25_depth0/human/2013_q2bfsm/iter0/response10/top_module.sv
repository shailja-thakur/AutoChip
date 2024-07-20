module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define state encoding
    typedef enum reg [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5,
        STATE_G = 3'd6
    } state_t;
    
    // State registers
    reg [2:0] current_state, next_state;
    
    // Input sequence detection
    reg [1:0] x_history;
    
    // Clock cycles counter for y input monitoring
    reg [1:0] y_counter;
    
    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_history <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) f <= 1'b1;
            else f <= 1'b0;

            if (current_state == STATE_E && x_history == 2'b11 && x == 1'b0)
                g <= 1'b1;
            else if ((current_state == STATE_F && y == 1'b1) || (current_state == STATE_G))
                g <= 1'b1;
            else
                g <= 1'b0;

            if (current_state == STATE_E || current_state == STATE_F) begin
                x_history <= {x_history[0], x};
            end else begin
                x_history <= 2'b00;
            end

            if (current_state == STATE_F) begin
                if (y != 1'b1) y_counter <= y_counter + 1'd1;
                else y_counter <= 0;
            end else begin
                y_counter <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (resetn == 1'b1) ? STATE_B : STATE_A;
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = (x == 1'b0) ? STATE_D : STATE_C;
            STATE_D: next_state = (x == 1'b1) ? STATE_E : STATE_C;
            STATE_E: next_state = (x_history == 2'b01 && x == 1'b1) ? STATE_F : STATE_D;
            STATE_F: next_state = (y == 1'b1) ? STATE_G : ((y_counter == 2'd2) ? STATE_A : STATE_F);
            STATE_G: next_state = STATE_G;
            default: next_state = STATE_A;
        endcase
    end

endmodule
