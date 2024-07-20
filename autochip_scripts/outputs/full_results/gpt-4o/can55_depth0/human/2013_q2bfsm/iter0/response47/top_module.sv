module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State definition
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110,
        STATE_H = 3'b111
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] x_counter;
    reg [1:0] y_counter;

    // State transition
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_counter <= 0;
            y_counter <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                    f = 1;
                end
            end

            STATE_B: begin
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x == 1) begin
                    next_state = STATE_D;
                    x_counter = 1;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_D: begin
                if (x == 0) begin
                    next_state = STATE_E;
                    x_counter = 2;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_E: begin
                if (x == 1) begin
                    next_state = STATE_F;
                    g = 1;
                    x_counter = 0;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_F: begin
                next_state = STATE_G;
                g = 1;
            end

            STATE_G: begin
                if (y == 1) begin
                    next_state = STATE_H;
                    g = 1;
                end else if (y_counter == 2) begin
                    next_state = STATE_A;
                    g = 0;
                    y_counter = 0;
                end else begin
                    y_counter = y_counter + 1;
                    next_state = STATE_G;
                    g = 1;
                end
            end

            STATE_H: begin
                g = 1;
            end
            
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
