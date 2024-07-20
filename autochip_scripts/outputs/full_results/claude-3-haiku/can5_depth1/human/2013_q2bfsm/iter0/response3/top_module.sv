module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
reg [1:0] state, next_state;
reg [1:0] x_history;

always @(posedge clk) begin
    if (~resetn) begin
        state <= STATE_A;
        x_history <= 2'b00;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        x_history <= {x_history[0], x};
    end
end

always @(*) begin
    next_state = state;
    f = 0;
    g = g;

    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
                f = 1;
            end
        end
        STATE_B: begin
            if (x_history == 2'b101) begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (y) begin
                next_state = STATE_D;
                g = 1;
            end
            else if (x_history[1] == 0 && x_history[0] == 1) begin
                next_state = STATE_A;
                g = 0;
            end
        end
        STATE_D: begin
            g = 1;
        end
    endcase
end

endmodule
