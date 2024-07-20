module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

    // State Encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_SET_F = 3'b001,
        STATE_MONITOR_X = 3'b010,
        STATE_MONITOR_Y = 3'b011,
        STATE_G_ACTIVE = 3'b100
    } state_t;

    // FSM state and next state
    state_t state, next_state;

    // Shift register to monitor the x sequence
    reg [2:0] x_shift;

    // Counter for monitoring y
    reg [1:0] y_counter;

    // FSM - state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // FSM - next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (resetn)
                    next_state = STATE_SET_F;
                else
                    next_state = STATE_A;
            end

            STATE_SET_F: begin
                f = 1;
                g = 0;
                next_state = STATE_MONITOR_X;
            end

            STATE_MONITOR_X: begin
                f = 0;
                g = 0;
                if (x_shift == 3'b101)
                    next_state = STATE_MONITOR_Y;
                else
                    next_state = STATE_MONITOR_X;
            end

            STATE_MONITOR_Y: begin
                f = 0;
                g = 1;
                next_state = (y_counter == 2'b10) ? STATE_G_ACTIVE : STATE_MONITOR_Y;
            end

            STATE_G_ACTIVE: begin
                f = 0;
                if (y == 1)
                    g = 1;
                else
                    g = 0;
                next_state = STATE_G_ACTIVE;
            end

            default: next_state = STATE_A;
        endcase
    end

    // Shift register for x input
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            x_shift <= 3'b000;
        else if (state == STATE_MONITOR_X)
            x_shift <= {x_shift[1:0], x};
    end

    // Counter for y input
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            y_counter <= 2'b00;
        else if (state == STATE_MONITOR_Y)
            y_counter <= y_counter + 1'b1;
    end

endmodule
