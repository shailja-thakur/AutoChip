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
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;
    reg [1:0] y_check_counter;

    always_ff @(posedge clk) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_check_counter <= 2'b00;
        end else begin
            state <= next_state;
            
            // State transitions
            case (state)
                STATE_A: f <= 1'b0;
                STATE_B: f <= 1'b1;
                STATE_C: f <= 1'b0;
                STATE_D: f <= 1'b0;
                STATE_E: f <= 1'b0;
                STATE_F: f <= 1'b0;
            endcase
            
            if (state == STATE_E) begin
                if (y == 1'b1) begin
                    g <= 1'b1;
                    y_check_counter <= 2'b00;
                end else if (y_check_counter == 2'b10) begin
                    g <= 1'b0;
                    y_check_counter <= 2'b00;
                end else begin
                    y_check_counter <= y_check_counter + 1;
                end
            end
        end
    end

    always_comb begin
        case (state)
            STATE_A: begin
                next_state = resetn ? STATE_B : STATE_A;
            end
            STATE_B: begin
                next_state = STATE_C; // output f is set to 1 in this cycle
            end
            STATE_C: begin
                if (x == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                next_state = x ? STATE_E : STATE_C;
            end
            STATE_E: begin
                next_state = (x == 1'b1) ? STATE_F : STATE_D;
            end
            STATE_F: begin
                if (g) begin
                    if (y_check_counter == 0 && y == 1) 
                        next_state = STATE_F;
                    else if (y_check_counter < 2) 
                        next_state = STATE_F;
                    else   
                        next_state = STATE_A; // Outputs remain unchanged in this state
                end else 
                    next_state = STATE_A;
            end
        endcase
    end

endmodule
