module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
reg [1:0] state, next_state;
reg [1:0] x_history;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_history <= 0;
    end
    else begin
        state <= next_state;
        f <= (state == STATE_A && next_state == STATE_B) ? 1 : 0;
        if (state == STATE_C) begin
            if (y == 1) begin
                g <= 1;
            end
            else if (x_history == 3'b101) begin
                g <= 0;
            end
        end
        x_history <= {x_history[0:0], x};
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            if (x_history == 3'b101) begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (y == 1) begin
                next_state = STATE_D;
            end
            else if (x_history != 3'b101) begin
                next_state = STATE_B;
            end
        end
        STATE_D: begin
            // Remain in STATE_D
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
