module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_F_ONE = 3'b001,
        STATE_X_1 = 3'b010,
        STATE_X_0 = 3'b011,
        STATE_X_1_2 = 3'b100,
        STATE_Y_CHECK = 3'b101,
        STATE_G_ONE = 3'b110,
        STATE_G_ZERO = 3'b111
    } state_t;

    state_t current_state, next_state;
    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        f = 0;
        
        case (current_state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_F_ONE;
            end
            STATE_F_ONE: begin
                f = 1;
                next_state = STATE_X_1;
            end
            STATE_X_1: begin
                f = 0;
                if (x)
                    next_state = STATE_X_0;
            end
            STATE_X_0: begin
                if (!x)
                    next_state = STATE_X_1_2;
            end
            STATE_X_1_2: begin
                if (x)
                    next_state = STATE_Y_CHECK;
            end
            STATE_Y_CHECK: begin
                g = 1;
                y_counter = 0;
                if (y)
                    next_state = STATE_G_ONE;
                else 
                    next_state = STATE_Y_CHECK;
            end
            STATE_G_ONE: begin
                g = 1;
                next_state = STATE_G_ONE;
            end
            STATE_G_ZERO: begin
                g = 0;
                next_state = STATE_G_ZERO;
            end
        endcase
    end

    always @(posedge clk) begin
        if (current_state == STATE_Y_CHECK) begin
            if (y) begin
                next_state = STATE_G_ONE;
            end else if (y_counter == 2) begin
                next_state = STATE_G_ZERO;
            end else begin
                y_counter = y_counter + 1;
            end
        end
    end
endmodule
