module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'd0;
localparam STATE_B = 2'd1;
localparam STATE_C = 2'd2;
localparam STATE_D = 2'd3;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= STATE_A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_A: begin
            f = 0;
            g = 0;
            next_state = (resetn) ? STATE_B : STATE_A;
        end
        STATE_B: begin
            f = 1;
            g = 0;
            next_state = STATE_C;
        end
        STATE_C: begin
            f = 0;
            g = (x == 1 && next_state == STATE_D) ? 1 : 0;
            next_state = (x == 1) ? STATE_D : STATE_C;
        end
        STATE_D: begin
            f = 0;
            g = (y == 1) ? 1 : ((next_state == STATE_E) ? 0 : g);
            next_state = (y == 1) ? STATE_E : ((next_state == STATE_E) ? STATE_D : STATE_D);
        end
        STATE_E: begin
            f = 0;
            g = 1;
            next_state = STATE_E;
        end
        default: begin
            f = 0;
            g = 0;
            next_state = STATE_A;
        end
    endcase
end

endmodule
