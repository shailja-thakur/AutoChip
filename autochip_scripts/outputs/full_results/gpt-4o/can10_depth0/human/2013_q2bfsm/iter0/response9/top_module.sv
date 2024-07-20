module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5,
        STATE_G = 3'd6
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_counter;
    
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            y_counter <= 2'd0; 
        end else begin
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                    y_counter <= 2'd0;
                end
                STATE_B: begin
                    f <= 1; // output f = 1 for one clock cycle
                end
                STATE_C: begin
                    f <= 0;
                end
                STATE_F: begin
                    y_counter <= y_counter + 1;
                end
                default: begin
                    // Do nothing
                end
            endcase
        end
    end
    
    always_comb begin
        next_state = state;
        
        case (state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (!x)
                    next_state = STATE_E;
            end
            STATE_E: begin
                if (x)
                    next_state = STATE_F;
            end
            STATE_F: begin
                if (y) begin
                    next_state = STATE_G;
                    g <= 1;
                end else if (y_counter == 2'd1) begin
                    next_state = STATE_A;
                    g <= 0;
                end
            end
            STATE_G: begin
                // Stay here indefinitely until reset
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
