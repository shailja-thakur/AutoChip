module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    typedef enum reg [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F
    } state_t;
    
    reg [2:0] state, next_state;
    reg [1:0] x_seq;
    reg [1:0] y_counter;
    reg y_check;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            x_seq <= 2'b00;
            y_counter <= 2'b00;
            y_check <= 1'b0;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
            if (state == STATE_B) begin
                f <= 1'b1;
            end else if (state == STATE_C) begin
                f <= 1'b0;
            end else if (state == STATE_D) begin
                x_seq <= {x_seq[0], x};
            end else if (state == STATE_E) begin
                x_seq <= 2'b00;
            end else if (state == STATE_F) begin
                if (y_counter == 2'b00) begin
                    y_check <= 1'b0;
                end else begin
                    y_check <= y || y_check;
                    y_counter <= y_counter - 1;
                end
            end
        end
    end

    always @* begin
        next_state = state;
        case (state)
            STATE_A: begin
                f = 1'b0;
                g = 1'b0;
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            STATE_C: begin
                f = 1'b0;
                next_state = STATE_D;
            end
            STATE_D: begin
                if (x_seq == 2'b10 && x == 1'b1) begin
                    g = 1'b1;
                    next_state = STATE_F;
                    y_counter = 2;
                    y_check = 1'b0;
                end else begin
                    g = 1'b0;
                    next_state = STATE_D;
                end
            end
            STATE_E: begin
                g = 1'b0;
                next_state = STATE_D;
            end
            STATE_F: begin
                if (y_check) begin
                    g = 1'b1;
                end else if (y_counter == 2'b00) begin
                    g = 1'b0;
                end else begin
                    g = 1'b1;
                end
            end
        endcase
    end
endmodule
