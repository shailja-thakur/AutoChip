module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] state;
reg [1:0] x_history;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_history <= 2'b00;
        f <= 0;
        g <= 0;
    end
    else begin
        case (state)
            STATE_A: begin
                f <= 0;
                g <= 0;
                if (x == 1'b1) begin
                    state <= STATE_B;
                    x_history <= {x_history[0], x};
                end
                else begin
                    x_history <= {x_history[0], x};
                end
            end
            STATE_B: begin
                f <= 1;
                g <= 0;
                state <= STATE_C;
                x_history <= {x_history[0], x};
            end
            STATE_C: begin
                f <= 0;
                if (x_history == 2'b10) begin
                    state <= STATE_D;
                    g <= 1;
                end
                else begin
                    state <= STATE_C;
                    g <= 0;
                end
                x_history <= {x_history[0], x};
            end
            STATE_D: begin
                f <= 0;
                if (y == 1'b1) begin
                    g <= 1;
                end
                else if (y == 1'b0 && x_history == 2'b01) begin
                    g <= 0;
                end
                x_history <= {x_history[0], x};
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
