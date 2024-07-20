module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] { 
        STATE_A = 3'd0, 
        STATE_B = 3'd1, 
        STATE_C = 3'd2, 
        STATE_D = 3'd3, 
        STATE_E = 3'd4, 
        STATE_F = 3'd5, 
        STATE_G = 3'd6 
    } state_t;

    state_t state, next_state;
    reg [2:0] x_seq; // Monitoring x sequence
    reg [1:0] y_counter; // Counter for y monitoring within 2 cycles

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_seq <= 3'd0;
            y_counter <= 2'd0;
        end else begin
            state <= next_state;
            
            if (state == STATE_B) begin
                f <= 1;
            end else begin
                f <= 0;
            end

            case(state)
                STATE_C: x_seq <= {x_seq[1:0], x};
                STATE_D: x_seq <= {x_seq[1:0], x};
                STATE_E: x_seq <= {x_seq[1:0], x};
                default: x_seq <= 3'd0;
            endcase

            if (state == STATE_F) begin
                if (y == 1) y_counter <= 2'd3; // y_flag remains high if y == 1
                else if (y_counter != 2'd0) y_counter <= y_counter - 1;
            end else begin
                y_counter <= 2'd0;
            end

            if (state == STATE_E && x_seq == 3'b101) g <= 1;
            else if (state == STATE_F && y_counter == 2'd0) g <= 0;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: 
                if (resetn) next_state = STATE_B;
            STATE_B: 
                next_state = STATE_C;
            STATE_C: 
                if (x_seq == 3'b101) next_state = STATE_E;
                else next_state = STATE_D;
            STATE_D: 
                next_state = STATE_C; 
            STATE_E: 
                next_state = STATE_F;
            STATE_F: 
                if (g == 1 && y_counter == 0) next_state = STATE_G; 
            STATE_G: 
                if (~resetn) next_state = STATE_A;
            default: 
                next_state = STATE_A;
        endcase
    end
endmodule
