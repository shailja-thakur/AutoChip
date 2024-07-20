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
        STATE_F,
        STATE_G
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;
        
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (!x) begin
                    next_state = STATE_E;
                end else if (x) begin
                    next_state = STATE_D;
                end
            end
            STATE_E: begin
                if (x) begin
                    next_state = STATE_F;
                end
            end
            STATE_F: begin
                g = 1'b1;
                if (y) begin
                    next_state = STATE_G;
                end else begin
                    next_state = STATE_F;
                end
            end
            STATE_G: begin
                g = 1'b1;
            end
        endcase
    end
endmodule
