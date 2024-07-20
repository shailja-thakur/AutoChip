module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

    // State Definitions
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] y_counter;

    // Output Logic
    always @(*) begin
        f = 0;
        g = 0;
        case (current_state)
            STATE_A: f = 0;
            STATE_B: f = 1;
            STATE_C, STATE_D, STATE_E, STATE_F: f = 0;
            STATE_G: g = 1;
        endcase
    end

    // State Transition Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_A: if (~resetn) next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: if (x == 1) next_state = STATE_D;
            STATE_D: if (x == 0) next_state = STATE_E;
            STATE_E: if (x == 1) next_state = STATE_F;
            STATE_F: if (y == 1) next_state = STATE_G;
            STATE_G: next_state = STATE_G;
        endcase
    end
    
    // Counter Logic
    always @(posedge clk) begin
        if (~resetn) begin
            y_counter <= 2'b00;
        end else begin
            if (current_state == STATE_F || current_state == STATE_G) begin
                y_counter <= y_counter + 1'b1;
            end
        end
    end
    
    // State Register with Reset
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Ensure g set permanently
    always @(posedge clk) begin
        if (current_state == STATE_G) begin
            if (y_counter < 2 && y == 1) begin
                g <= 1;
            end else if (y_counter >= 2) begin
                g <= 0;
            end
        end
    end
    
endmodule
