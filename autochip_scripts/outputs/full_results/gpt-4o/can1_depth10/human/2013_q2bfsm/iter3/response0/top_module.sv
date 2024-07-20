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
    reg [1:0] x_seq; // Monitoring x sequence (2 bits to track last 2 states)
    reg [1:0] y_counter; // Counter for y monitoring within 2 cycles

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_seq <= 2'd0;
            y_counter <= 2'd0;
        end else begin
            state <= next_state;
            
            if (state == STATE_B)
                f <= 1;
            else
                f <= 0;

            if (state == STATE_C || state == STATE_D || state == STATE_E) 
                x_seq <= {x_seq[0], x};

            if (state == STATE_E && x_seq == 2'b10 && x == 1) begin
                g <= 1;
                y_counter <= 2'd2; // Start monitoring y for 2 cycles
            end

            if (y_counter != 2'd0) begin
                if (y == 1) begin
                    g <= 1; // Maintain g = 1 permanently
                    y_counter <= 2'd0; // Stop checking y
                end else
                    y_counter <= y_counter - 1;

                if (y_counter == 1)
                    g <= 0; // Set g = 0 if y is not 1 within 2 cycles
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
                if (x_seq == 2'b10 && x == 1) next_state = STATE_F;
                else next_state = STATE_C;
                
            STATE_F: 
                if (~resetn) next_state = STATE_A;
                
            default: 
                next_state = STATE_A;
        endcase
    end
endmodule
