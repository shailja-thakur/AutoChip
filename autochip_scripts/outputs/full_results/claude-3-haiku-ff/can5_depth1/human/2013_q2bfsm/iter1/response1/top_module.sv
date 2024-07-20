module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'd0;
localparam STATE_B = 2'd1;
localparam STATE_C = 2'd2;
localparam STATE_D = 2'd3;

reg [1:0] state, next_state;
reg [1:0] x_count;
reg [1:0] y_count;

always @(posedge clk) begin
    if (~resetn) begin
        state <= STATE_A;
        x_count <= 2'b00;
        y_count <= 2'b00;
        f <= 1'b0;
        g <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == STATE_C && x == 1'b1) begin
            x_count <= x_count + 2'b01;
        end
        else begin
            x_count <= 2'b00;
        end
        if (state == STATE_D && y == 1'b1) begin
            y_count <= y_count + 2'b01;
        end
        else begin
            y_count <= 2'b00;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            f = 1'b0;
            g = 1'b0;
            if (resetn) begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            f = 1'b1;
            g = 1'b0;
            next_state = STATE_C;
        end
        STATE_C: begin
            f = 1'b0;
            if (x_count == 2'b11) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            g = 1'b1;
            if (y_count == 2'b10) begin
                next_state = STATE_D;
            end
            else begin
                g = 1'b0;
                next_state = STATE_C;
            end
        end
        default: begin
            f = 1'b0;
            g = 1'b0;
            next_state = STATE_A;
        end
    endcase
end

endmodule
