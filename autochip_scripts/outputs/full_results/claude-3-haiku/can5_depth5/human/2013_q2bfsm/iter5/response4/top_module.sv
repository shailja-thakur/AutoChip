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
reg x_history [2:0];
reg y_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_history[0] <= 0;
        x_history[1] <= 0;
        x_history[2] <= 0;
        y_count <= 0;
    end else begin
        state <= next_state;
        x_history[0] <= x;
        x_history[1] <= x_history[0];
        x_history[2] <= x_history[1];
        if (y == 1) begin
            y_count <= 2'b11;
        end else if (y_count != 0) begin
            y_count <= y_count - 1;
        end
    end
end

always @(*) begin
    next_state = state;
    f = 0;
    g = 0;
    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            f = 1;
            next_state = STATE_C;
        end
        STATE_C: begin
            if (x_history[0] == 1 && x_history[1] == 0 && x_history[2] == 1) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            g = 1;
            next_state = STATE_E;
        end
        STATE_E: begin
            if (y_count == 2'b11) begin
                g = 1;
            end else begin
                g = 0;
            end
            next_state = STATE_E;
        end
    endcase
end

endmodule
