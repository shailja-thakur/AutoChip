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
    reg [2:0] x_seq; // Monitoring x sequence (3 bits to track last 3 states)
    reg [1:0] y_counter; // Counter for y monitoring

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_seq <= 3'd0;
            y_counter <= 2'd0;
        end else begin
            state <= next_state;

            f <= (state == STATE_B) ? 1'b1 : 1'b0;

            if (state == STATE_C || state == STATE_D || state == STATE_E)
                x_seq <= {x_seq[1:0], x};
            
            if (state == STATE_F) begin
                if (y == 1) begin
                    g <= 1; // Maintain g = 1 permanently
                    y_counter <= 2'd0;
                end else if (y_counter == 2'd2) begin
                    g <= 0; // Set g = 0 if y is not 1 within 2 cycles
                end else begin
                    y_counter <= y_counter + 1'b1;
                end
            end else if (state == STATE_E && x_seq == 3'b101) begin
                g <= 1; 
            end
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
                next_state = STATE_D;
                
            STATE_D: 
                next_state = STATE_E;
                
            STATE_E: 
                if (x_seq == 3'b101) next_state = STATE_F;
                else next_state = STATE_C;
                
            STATE_F: 
                if (~resetn) next_state = STATE_A;
                else next_state = STATE_F;

            default: 
                next_state = STATE_A;
        endcase
    end
endmodule
