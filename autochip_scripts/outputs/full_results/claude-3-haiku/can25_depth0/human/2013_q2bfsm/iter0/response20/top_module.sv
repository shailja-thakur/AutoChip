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

always @(posedge clk, negedge resetn) begin
    if (~resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_B) begin
            f <= 1;
        end
        else begin
            f <= 0;
        end
        if (state == STATE_D && y == 1) begin
            g <= 1;
        end
        else if (state == STATE_D && y != 1) begin
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
            end
        end
        STATE_B: begin
            if (x == 1) begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (x == 0) begin
                next_state = STATE_D;
            end
        end
        STATE_D: begin
            if (x == 1) begin
                x_count <= x_count + 1;
                if (x_count == 2) begin
                    next_state = STATE_D;
                end
            end
            else begin
                x_count <= 0;
            end
        end
    endcase
end

endmodule
