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

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        state <= next_state;
        f <= (state == STATE_B) ? 1 : 0;
        case (state)
            STATE_C: begin
                if (y) begin
                    g <= 1;
                end
                else if (x_count == 2'b10) begin
                    g <= 0;
                end
            end
            STATE_D: begin
                g <= 1;
            end
            default: begin
                g <= g;
            endcase
        end
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            next_state = (resetn) ? STATE_B : STATE_A;
            x_count = 0;
        end
        STATE_B: begin
            next_state = STATE_C;
            x_count = 0;
        end
        STATE_C: begin
            if (x == 1) begin
                x_count = x_count + 1;
                next_state = STATE_C;
            end
            else if (x_count == 2'b10) begin
                next_state = STATE_D;
                x_count = 0;
            end
            else begin
                next_state = STATE_C;
                x_count = x_count;
            end
        end
        STATE_D: begin
            if (y) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_E;
            end
            x_count = 0;
        end
        STATE_E: begin
            next_state = STATE_E;
            x_count = 0;
        end
        default: begin
            next_state = STATE_A;
            x_count = 0;
        end
    endcase
end

endmodule
