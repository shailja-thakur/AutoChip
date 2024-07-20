module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
reg [1:0] state, next_state;
reg x_history [1:0];

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, x, y) begin
    next_state = state;
    f = 0;
    g = g;
    case (state)
        A: begin
            f = 0;
            g = 0;
            if (resetn) begin
                next_state = B;
                f = 1;
            end
        end
        B: begin
            x_history[0] <= x;
            x_history[1] <= x_history[0];
            if (x_history[0] == 1 && x_history[1] == 0 && x == 1) begin
                next_state = C;
            end
        end
        C: begin
            g = 1;
            if (y == 1) begin
                next_state = D;
            end else if (y == 0 && !&x_history) begin
                next_state = B;
            end
        end
        D: begin
            g = 1;
        end
    endcase
end

endmodule
