module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        state <= next_state;
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
            if (x == 1) begin
                next_state = STATE_C;
                x_count = 1;
            end
            else begin
                x_count = 0;
            end
        end
        STATE_C: begin
            if (x == 0) begin
                next_state = STATE_D;
                x_count = 2;
            end
            else begin
                x_count = 0;
            end
        end
        STATE_D: begin
            if (x == 1) begin
                next_state = STATE_E;
                g = 1;
            end
            else begin
                x_count = 0;
            end
        end
        STATE_E: begin
            if (y == 1) begin
                g = 1;
            end
            else if (x_count == 2) begin
                g = 0;
            end
        end
    endcase
end

endmodule
