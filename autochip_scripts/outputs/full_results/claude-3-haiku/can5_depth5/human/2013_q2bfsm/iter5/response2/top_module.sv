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
reg [1:0] x_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
    end else begin
        state <= next_state;
        if (state == STATE_C && x == 1) begin
            x_count <= x_count + 1;
        end else begin
            x_count <= 0;
        end
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
            end
        end
        STATE_B: begin
            f = 1;
            next_state = STATE_C;
        end
        STATE_C: begin
            if (x_count == 2) begin
                next_state = STATE_D;
            end
        end
        STATE_D: begin
            if (y == 1) begin
                g = 1;
                next_state = STATE_E;
            end else if (y == 0) begin
                g = 0;
                next_state = STATE_E;
            end
        end
        STATE_E: begin
            g = g;
        end
    endcase
end

endmodule
