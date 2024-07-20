module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    localparam [1:0] STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
    reg [1:0] state, next_state;
    reg [1:0] x_count;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            x_count <= 0;
        end
        else begin
            state <= next_state;
            if (state == STATE_B && x == 1)
                x_count <= x_count + 1;
            else
                x_count <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                next_state = STATE_B;
                f = 1;
                g = 0;
            end
            STATE_B: begin
                if (x_count == 3)
                    next_state = STATE_C;
                else
                    next_state = STATE_B;
                f = 0;
                g = 0;
            end
            STATE_C: begin
                if (y == 1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
                f = 0;
                g = 1;
            end
            STATE_D: begin
                next_state = STATE_D;
                f = 0;
                g = 1;
            end
            default: begin
                next_state = STATE_A;
                f = 0;
                g = 0;
            end
        endcase
    end

endmodule
