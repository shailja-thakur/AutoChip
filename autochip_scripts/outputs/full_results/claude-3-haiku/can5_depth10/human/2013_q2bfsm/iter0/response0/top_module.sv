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
reg [1:0] x_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_B && x_count == 2'd2) begin
            g <= 1;
        end
        else if (state == STATE_C && y == 1) begin
            g <= 1;
        end
        else if (state == STATE_C && y == 0) begin
            g <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
                f = 1;
            end
            else begin
                f = 0;
            end
        end
        STATE_B: begin
            if (x == 1) begin
                x_count = x_count + 1;
            end
            else begin
                x_count = 0;
            end
            if (x_count == 2'd2) begin
                next_state = STATE_C;
            end
            f = 0;
        end
        STATE_C: begin
            if (y == 1) begin
                next_state = STATE_D;
            end
            else if (y == 0 && x_count == 2'd2) begin
                next_state = STATE_A;
                x_count = 0;
            end
            f = 0;
        end
        STATE_D: begin
            next_state = STATE_D;
            f = 0;
        end
    endcase
end

endmodule
