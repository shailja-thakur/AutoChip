module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'd0, // Reset state
        STATE_B = 3'd1, // Set f = 1 for one clock cycle
        STATE_C = 3'd2, // Observe x for 1
        STATE_D = 3'd3, // Observe x for 0
        STATE_E = 3'd4, // Observe x for 1
        STATE_F = 3'd5, // Output g = 1, observe y
        STATE_G = 3'd6, // Maintain g = 1 permanently
        STATE_H = 3'd7  // Maintain g = 0 permanently
    } state_t;

    state_t current_state, next_state;
    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
            
            if (current_state == STATE_F) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 2'b00;
            end
            
            if (next_state == STATE_G || next_state == STATE_F) begin
                g <= 1'b1;
            end else if (next_state == STATE_H) begin
                g <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x == 0) begin
                    next_state = STATE_E;
                end else if (x == 1) begin
                    next_state = STATE_C;
                end
            end
            STATE_E: begin
                if (x == 1) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_F: begin
                if (y == 1) begin
                    next_state = STATE_G;
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_H;
                end
            end
            STATE_G: begin
                // Stay in State G
            end
            STATE_H: begin
                // Stay in State H
            end
        endcase
    end

endmodule
