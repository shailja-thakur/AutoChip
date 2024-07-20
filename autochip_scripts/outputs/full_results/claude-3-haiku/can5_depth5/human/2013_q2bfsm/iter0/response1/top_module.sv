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

always @(posedge clk) begin
    if (~resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_A: begin
                f <= 0;
                g <= 0;
                x_count <= 0;
            end
            STATE_B: begin
                f <= 1;
                g <= 0;
                x_count <= 0;
            end
            STATE_C: begin
                f <= 0;
                x_count <= x_count + 1;
                if (x_count == 2'b10) begin
                    g <= 1;
                end
            end
            STATE_D: begin
                if (y == 1) begin
                    g <= 1;
                end
                else if (x_count == 2'b11) begin
                    g <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            next_state = STATE_C;
        end
        STATE_C: begin
            if (x_count == 2'b10) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            if (y == 1 || x_count == 2'b11) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_A;
            end
        end
    endcase
end

endmodule
