module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // States declaration
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_counter;
    
    always_ff @(posedge clk) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            state <= next_state;
            
            case (state)
                STATE_A: f <= 1;
                STATE_B: f <= 0;
                default: f <= 0;
            endcase
            
            case (next_state)
                STATE_F: g <= 1;
                STATE_E: if (y_counter != 2'b10) g <= 0;
                default: g <= g;
            endcase
        end
    end
    
    always_comb begin
        next_state = state;  // default assignment to avoid latches
        case (state)
            STATE_A: begin
                if (!resetn) 
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            
            STATE_B: begin
                next_state = STATE_C;
            end
            
            STATE_C: begin
                if (x == 1) 
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            
            STATE_D: begin
                if (x == 0) 
                    next_state = STATE_E;
                else
                    next_state = STATE_D;
            end
            
            STATE_E: begin
                if (x == 1) 
                    next_state = STATE_F;
                else
                    next_state = STATE_E;
            end
            
            STATE_F: begin
                if (y == 1)
                    y_counter <= 0;
                else if (y_counter < 2)
                    y_counter <= y_counter + 1;
                
                if (y == 1 || y_counter == 2)
                    next_state = STATE_F;
            end
            
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
