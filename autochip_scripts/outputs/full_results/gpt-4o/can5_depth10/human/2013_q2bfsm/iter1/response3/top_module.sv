module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
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
    reg [1:0] x_sequence;
    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_C) begin
                x_sequence <= {x_sequence[0], x};
            end
            if (current_state == STATE_F) begin
                if (y == 1'b1) begin
                    y_counter <= 2'b10; // Permanent g = 1
                end else begin
                    y_counter <= y_counter + 1;
                end
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        f = 0;
        g = 0;
        
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 2'b10) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x == 1) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_E: begin
                if (x == 0) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_F: begin
                g = 1;
                if (y_counter == 2'b01 && y != 1'b1) begin
                    next_state = STATE_H;
                end else if (y == 1'b1) begin
                    next_state = STATE_G;
                end
            end
            STATE_G: begin
                g = 1;
            end
            STATE_H: begin
                g = 0;
            end
        endcase
    end

endmodule
