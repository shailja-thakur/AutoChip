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

reg [1:0] state, next_state;
reg [1:0] x_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_count <= 0;
        f <= 0;
        g <= 0;
    end else begin
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
                g <= 0;
                x_count <= x_count + 1;
                if (x_count == 2'd2 && x) begin
                    next_state <= STATE_D;
                end
            end
            STATE_D: begin
                f <= 0;
                if (y) begin
                    g <= 1;
                end else begin
                    g <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_A: next_state = resetn ? STATE_B : STATE_A;
        STATE_B: next_state = STATE_C;
        STATE_C: next_state = (x_count == 2'd2) ? STATE_D : STATE_C;
        STATE_D: next_state = STATE_D;
    endcase
end

endmodule
