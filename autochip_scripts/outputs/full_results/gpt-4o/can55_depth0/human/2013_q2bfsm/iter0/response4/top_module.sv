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
    reg [1:0] y_timer;
    reg [2:0] x_seq;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_seq <= 3'b000;
            y_timer <= 2'b00;
        end
        else begin
            state <= next_state;
            
            case (next_state)
                STATE_B: f <= 1;
                default: f <= 0;
            endcase
            
            if (state == STATE_D) begin
                if (x) x_seq <= {x_seq[1:0], 1'b1};
                else x_seq <= {x_seq[1:0], 1'b0};
            end else begin
                x_seq <= 3'b000;
            end
            
            if (state == STATE_E) begin
                if (y_timer < 2'b10) 
                    y_timer <= y_timer + 1;
            end else begin
                y_timer <= 2'b00;
            end
            
            if (state == STATE_F)
                g <= 1;
        end
    end
    
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: if (resetn) next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_D;
            STATE_D: if (x_seq == 3'b101) next_state = STATE_E;
            STATE_E: if (y) next_state = STATE_F;
                    else if (y_timer == 2'b10) next_state = STATE_A;
            STATE_F: next_state = STATE_F;
            default: next_state = STATE_A;
        endcase
    end
    
endmodule
