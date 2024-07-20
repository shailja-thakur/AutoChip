module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    parameter STATE_A = 2'd0, STATE_B = 2'd1, STATE_C = 2'd2, STATE_D = 2'd3;
    reg [1:0] state, next_state;
    reg [1:0] x_count;
    reg y_count;

    always @(posedge clk, negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            x_count <= 0;
            y_count <= 0;
            f <= 0;
            g <= 0;
        end
        else begin
            state <= next_state;
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                    x_count <= 0;
                    y_count <= 0;
                end
                STATE_B: begin
                    f <= 1;
                    g <= 0;
                    x_count <= (x) ? x_count + 1 : 0;
                    y_count <= 0;
                end
                STATE_C: begin
                    f <= 0;
                    g <= (y_count == 2) ? 1 : g;
                    x_count <= 0;
                    y_count <= (y) ? y_count + 1 : 0;
                end
                STATE_D: begin
                    f <= 0;
                    g <= 1;
                    x_count <= 0;
                    y_count <= 0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            STATE_A: next_state = resetn ? STATE_B : STATE_A;
            STATE_B: next_state = (x_count == 2'd3) ? STATE_C : STATE_B;
            STATE_C: next_state = (y_count == 2) ? STATE_D : STATE_C;
            STATE_D: next_state = STATE_D;
            default: next_state = STATE_A;
        endcase
    end

endmodule
