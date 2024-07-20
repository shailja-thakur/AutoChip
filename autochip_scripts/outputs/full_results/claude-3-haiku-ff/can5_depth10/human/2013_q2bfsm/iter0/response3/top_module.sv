module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
parameter STATE_A = 2'd0, STATE_B = 2'd1, STATE_C = 2'd2, STATE_D = 2'd3;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
    end
    else begin
        case (state)
            STATE_A: begin
                f <= 0;
                g <= 0;
                if (resetn) begin
                    state <= STATE_B;
                end
            end
            STATE_B: begin
                f <= 1;
                g <= 0;
                state <= STATE_C;
            end
            STATE_C: begin
                f <= 0;
                if (x == 1) begin
                    state <= STATE_C;
                end
                else if (x == 0) begin
                    state <= STATE_C;
                end
                else if (x == 1) begin
                    state <= STATE_D;
                end
            end
            STATE_D: begin
                g <= 1;
                if (y == 1) begin
                    g <= 1;
                end
                else begin
                    g <= 0;
                end
            end
            default: begin
                state <= STATE_A;
                f <= 0;
                g <= 0;
            end
        endcase
    end
end

endmodule
