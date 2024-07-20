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
    STATE_F = 3'b101,
    STATE_G = 3'b110
} state_t;

// Registers for current and next state
state_t current_state, next_state;

// Registers for monitoring x and y
logic [1:0] x_history;
logic [1:0] y_monitor_timer;

// State transition and outputs logic
always_ff @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        current_state <= STATE_A;
        x_history <= 2'b00;
        y_monitor_timer <= 2'b00;
        f <= 1'b0;
        g <= 1'b0;
    end else begin
        current_state <= next_state;

        // Update history
        if (current_state == STATE_B || current_state == STATE_C || current_state == STATE_D) begin
            x_history <= {x_history[0], x};
        end

        // Update y monitor timer
        if (current_state == STATE_E) begin
            y_monitor_timer <= y_monitor_timer + 1;
        end else begin
            y_monitor_timer <= 2'b00;
        end
        
        // Handle outputs
        case (next_state)
            STATE_B: f <= 1'b1;
            STATE_E: g <= 1'b1;
            STATE_F: g <= 1'b0;
            STATE_G: g <= 1'b1;
            default: f <= 1'b0;
        endcase
    end
end

// Next state logic
always_comb begin
    next_state = current_state;
    case (current_state)
        STATE_A: begin
            if (~resetn) next_state = STATE_A;
            else next_state = STATE_B;
        end
        STATE_B: next_state = STATE_C;
        STATE_C: next_state = STATE_D;
        STATE_D: begin
            if (x_history == 2'b01 && x == 1'b1)
                next_state = STATE_E;
        end
        STATE_E: begin
            if (y == 1'b1)
                next_state = STATE_G;
            else if (y_monitor_timer == 2'b10)
                next_state = STATE_F;
        end
        STATE_F: next_state = STATE_F;
        STATE_G: next_state = STATE_G;
        default: next_state = STATE_A;
    endcase
end

endmodule
