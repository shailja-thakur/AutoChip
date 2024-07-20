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
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] x_seq;          // for storing x sequence 101
    reg [1:0] y_counter;      // for counting y input cycles

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (~resetn) 
            state <= STATE_A;
        else 
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state;    // Default: stay in current state
        f = 0;
        g = 0;
        case (state)
            STATE_A: begin
                if (~resetn) begin
                    next_state = STATE_A;
                end else begin
                    f = 1;
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                if (x == 1) begin
                    x_seq[1:0] = 2'b01;
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end

            STATE_C: begin
                if (x == 0) begin
                    x_seq[1] = 1;
                    x_seq[0] = 0;
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_D: begin
                if (x == 1) begin
                    x_seq[0] = 1;
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_B;  // If the sequence breaks, restart the checking process.
                end
            end

            STATE_E: begin
                g = 1;
                y_counter = 2;
                next_state = STATE_F;
            end

            STATE_F: begin
                g = 1;
                if (y == 1) begin
                    g = 1;
                    next_state = STATE_F;
                end else begin
                    if (y_counter == 0) begin
                        g = 0;
                        next_state = STATE_F;
                    end else begin
                        y_counter = y_counter - 1;
                        next_state = STATE_F;
                    end
                end
            end
            
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
    
endmodule
