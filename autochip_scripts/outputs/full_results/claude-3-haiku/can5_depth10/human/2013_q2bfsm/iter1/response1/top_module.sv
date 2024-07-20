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

always @(posedge clk) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_A: begin
                f <= 1;
                g <= 0;
                x_count <= 0;
            end
            STATE_B: begin
                f <= 0;
                if (x == 1) begin
                    x_count <= x_count + 1;
                end
                else begin
                    x_count <= 0;
                end
            end
            STATE_C: begin
                if (x_count == 3) begin
                    g <= 1;
                end
                else begin
                    g <= 0;
                end
            end
            STATE_D: begin
                if (y == 1) begin
                    g <= 1;
                end
                else if (x_count == 2) begin
                    g <= 0;
                end
            end
            default: begin
                f <= 0;
                g <= 0;
                x_count <= 0;
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
            if (x_count == 3) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_B;
            end
        end
        STATE_C: begin
            if (y == 1) begin
                next_state = STATE_D;
            end
            else if (x_count == 2) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            next_state = STATE_D;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
