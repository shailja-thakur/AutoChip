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
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] y_count;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            y_count <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default outputs and next state
        f = 0;
        next_state = state;
        
        case (state)
            STATE_A: begin
                f = 1;
                next_state = STATE_B;
            end
            
            STATE_B: begin
                if (x == 1) 
                    next_state = STATE_C;
            end
            
            STATE_C: begin
                if (x == 0)
                    next_state = STATE_D;
                else
                    next_state = STATE_B;
            end
            
            STATE_D: begin
                if (x == 1)
                    next_state = STATE_E;
                else
                    next_state = STATE_B;
            end
            
            STATE_E: begin
                g = 1;
                y_count = 2;
                next_state = STATE_F;
            end
            
            STATE_F: begin
                g = 1;
                if (y == 1)
                    next_state = STATE_G;
                else if (y_count == 0)
                    g = 0;
                else
                    y_count = y_count - 1;
            end
            
            STATE_G: 
                g = 1;
            
            default: begin
                next_state = STATE_A;
                f = 0;
                g = 0;
            end
        endcase
    end

endmodule
