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
        STATE_F = 3'd5 
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

            // Set f to 1 for one clock cycle in STATE_B
            if (state == STATE_B)
                f <= 1'b1;
            else 
                f <= 1'b0;

            // Update x_seq to monitor x input sequence
            if (state == STATE_C || state == STATE_D || state == STATE_E)
                x_seq <= {x_seq[1:0], x};

            // Update g and y_counter in state F
            if (state == STATE_F) begin
                if (y == 1) begin
                    g <= 1; // Maintain g = 1 permanently
                end else if (y_counter >= 1) begin
                    g <= 0; // Set g = 0 if y is not 1 within 2 cycles
                end else begin
                    y_counter <= y_counter + 1'b1;
                end
            end

            if (state != STATE_F) begin
                y_counter <= 2'd0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (resetn) next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_seq == 3'b101) 
                    next_state = STATE_F;
                else 
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (x_seq == 3'b101)
                    next_state = STATE_F;
                else 
                    next_state = STATE_E;
            end
            STATE_E: begin
                if (x_seq == 3'b101)
                    next_state = STATE_F;
            end
            STATE_F: begin
                if (~resetn) next_state = STATE_A;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
