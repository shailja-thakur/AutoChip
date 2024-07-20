module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

parameter STATE_A = 2'b00;
parameter STATE_B = 2'b01;
parameter STATE_C = 2'b10;
parameter STATE_D = 2'b11;

reg [1:0] state, next_state;
reg x_count;

always @(posedge clk) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_B)
            x_count <= x_count + 1;
        if (state == STATE_C)
            g <= 1;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            f = 0;
            g = 0;
            if (resetn)
                next_state = STATE_B;
        end
        STATE_B: begin
            f = 1;
            g = 0;
            if (x_count == 3)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        end
        STATE_C: begin
            f = 0;
            if (y == 1)
                next_state = STATE_D;
            else if (x_count == 5)
                next_state = STATE_A;
        end
        STATE_D: begin
            f = 0;
            g = 1;
            if (resetn)
                next_state = STATE_A;
            else
                next_state = STATE_D;
        end
    endcase
end

endmodule
