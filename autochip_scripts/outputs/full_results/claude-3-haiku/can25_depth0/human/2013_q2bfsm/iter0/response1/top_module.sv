module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00,
           STATE_B = 2'b01,
           STATE_C = 2'b10,
           STATE_D = 2'b11;

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
                if (y) begin
                    g <= 1;
                end
                else if (x_count == 2'b10) begin
                    g <= 0;
                end
                x_count <= x_count + 1;
            end
            STATE_D: begin
                f <= 0;
                g <= 1;
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
            if (x == 1) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_B;
            end
        end
        STATE_C: begin
            if (x_count == 2'b10) begin
                if (y) begin
                    next_state = STATE_D;
                end
                else begin
                    next_state = STATE_C;
                end
            end
            else begin
                next_state = STATE_C;
            end
        end
        STATE_D: begin
            next_state = STATE_D;
        end
    endcase
end

endmodule
