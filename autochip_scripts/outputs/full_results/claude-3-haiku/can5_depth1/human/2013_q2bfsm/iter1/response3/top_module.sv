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
reg y_count;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
        y_count <= 0;
        f <= 0;
        g <= 0;
    end
    else begin
        state <= next_state;
        f <= (state == STATE_B) ? 1'b1 : 1'b0;
        if (state == STATE_C && x_count == 2'b11) begin
            x_count <= 0;
        end
        else begin
            x_count <= {x_count[0], x};
        end
        if (state == STATE_D) begin
            if (y) begin
                y_count <= 1'b1;
            end
            else begin
                y_count <= y_count + 1'b1;
            end
        end
        else begin
            y_count <= 1'b0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            g <= 0;
            if (resetn) begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            next_state = STATE_C;
        end
        STATE_C: begin
            if (x_count == 2'b11) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            if (y_count == 2'b10) begin
                g <= 1'b0;
            end
            else begin
                g <= 1'b1;
            end
            next_state = STATE_D;
        end
        default: begin
            g <= 0;
            next_state = STATE_A;
        end
    endcase
end

endmodule
