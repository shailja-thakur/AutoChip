module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_B && x_count == 2'b11) begin
            x_count <= 0;
        end
        else begin
            x_count <= {x_count[0], x};
        end
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
            if (x_count == 2'b11) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            if (y == 1 && x_count == 2'b10) begin
                g = 1;
            end
            else if (x_count == 2'b10) begin
                g = 0;
            end
            next_state = STATE_D;
        end
        default: begin
            f = 0;
            g = 0;
            next_state = STATE_A;
        end
    endcase
end

endmodule
