module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
    reg [1:0] current_state, next_state;
    reg [1:0] x_count;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_count <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            current_state <= next_state;
            case (current_state)
                STATE_A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    x_count <= 2'b00;
                end
                STATE_B: begin
                    f <= 1'b1;
                    g <= 1'b0;
                    x_count <= x_count + 1'b1;
                end
                STATE_C: begin
                    f <= 1'b0;
                    if (y == 1'b1) begin
                        g <= 1'b1;
                    end
                    else if (x_count == 2'b10) begin
                        g <= 1'b0;
                    end
                end
                STATE_D: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
            endcase
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
                else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (x == 1'b1) begin
                    next_state = STATE_B;
                end
                else if (x == 1'b0) begin
                    next_state = STATE_C;
                end
                else begin
                    next_state = STATE_A;
                end
            end
            STATE_C: begin
                if (x == 1'b1) begin
                    next_state = STATE_C;
                end
                else if (y == 1'b1) begin
                    next_state = STATE_D;
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
