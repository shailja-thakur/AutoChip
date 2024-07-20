module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define state encoding
    typedef enum logic [2:0] {
        STATE_A = 3'd0,  // Reset state
        STATE_B = 3'd1,  // Set f = 1 for one clock cycle
        STATE_C = 3'd2,  // Waiting for x to be 1
        STATE_D = 3'd3,  // Waiting for x to be 0
        STATE_E = 3'd4,  // Waiting for x to be 1
        STATE_F = 3'd5,  // Set g = 1, monitor y
        STATE_G = 3'd6,  // Maintain g = 1 permanently
        STATE_H = 3'd7   // Maintain g = 0 permanently
    } state_t;

    state_t current_state, next_state;
    reg [1:0] y_counter;
    reg f_flag;

    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'd0;
            f_flag <= 1'b0;
        end else begin
            current_state <= next_state;

            if (current_state == STATE_B) begin
                f_flag <= 1'b1;
            end else begin
                f_flag <= 1'b0;
            end

            if (current_state == STATE_F) begin
                if (y_counter < 2'd2) begin
                    y_counter <= y_counter + 1;
                end
            end else begin
                y_counter <= 2'd0;
            end

            if (current_state == STATE_G || (current_state == STATE_F && y == 1)) begin
                g <= 1'b1;
            end else if (current_state == STATE_H || (current_state == STATE_F && y_counter == 2'd2)) begin
                g <= 1'b0;
            end
        end
    end

    always @( * ) begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1) next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 0) next_state = STATE_E;
            end
            STATE_E: begin
                if (x == 1) next_state = STATE_F;
            end
            STATE_F: begin
                if (y == 1) next_state = STATE_G;
                else if (y_counter == 2'd2) next_state = STATE_H;
            end
            STATE_G: begin
                // Stay in state
            end
            STATE_H: begin
                // Stay in state
            end
            default: next_state = STATE_A;
        endcase
    end

    always @(posedge clk) begin
        f <= f_flag;
    end

endmodule
