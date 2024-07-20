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
    reg [1:0] y_wait; // Counter to track y

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            y_wait <= 0;
        end
        else begin
            case (state)
                STATE_A: begin
                    if (resetn) begin
                        f <= 1;
                        g <= 0;
                    end
                end
                
                STATE_B: begin
                    f <= 0;
                end
                
                STATE_C: begin
                    if (x) next_state <= STATE_D;
                end
                
                STATE_D: begin
                    if (!x) next_state <= STATE_E;
                end
                
                STATE_E: begin
                    if (x) next_state <= STATE_F;
                end
                
                STATE_F: begin
                    g <= 1;
                end
                
                STATE_G: begin
                    if (y_wait == 2'b10)
                        g <= 0;
                end
                
                default: state <= STATE_A;
            endcase
            
            if (state == STATE_E && next_state == STATE_F)
                y_wait <= 2'b0;
            else if (state == STATE_F)
                y_wait <= y_wait + 1;
        end
    end

    always @(*) begin
        next_state = state;
        
        case (state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_B;
            end
            
            STATE_B: next_state = STATE_C;
            
            STATE_C: if (x) next_state = STATE_D;
            
            STATE_D: if (!x) next_state = STATE_E;
            
            STATE_E: if (x) next_state = STATE_F;
            
            STATE_F: if (y)
                        next_state = STATE_F;
                      else if (y_wait == 2'b10)
                        next_state = STATE_G;
            
            STATE_G: ;

            default: next_state = STATE_A;
        endcase
    end
endmodule
