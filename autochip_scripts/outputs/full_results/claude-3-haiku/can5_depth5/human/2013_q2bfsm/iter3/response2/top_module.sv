module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 0, STATE_B = 1, STATE_C = 2, STATE_D = 3, STATE_E = 4;
reg [2:0] state, next_state;
reg x_history[2:0];

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_history <= 3'b0;
    end else begin
        state <= next_state;
        x_history <= {x_history[1:0], x};
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            f = 0;
            g = 0;
            if (resetn) begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            f = 1;
            g = 0;
            next_state = STATE_C;
        end
        STATE_C: begin
            f = 0;
            if (x_history == 3'b101) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            f = 0;
            g = 1;
            if (y == 1) begin
                next_state = STATE_E;
            end else if (y == 0 && g == 1) begin
                next_state = STATE_E;
            end else begin
                next_state = STATE_D;
            end
        end
        STATE_E: begin
            f = 0;
            g = 1;
            next_state = STATE_E;
        end
    endcase
end

endmodule
