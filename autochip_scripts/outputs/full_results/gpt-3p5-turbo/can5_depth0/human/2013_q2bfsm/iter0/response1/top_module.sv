module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg f_reg;
reg g_reg;
reg [1:0] state;
reg [2:0] x_history;
reg y_detect;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 2'b00;
        f_reg <= 1'b0;
        g_reg <= 1'b0;
        x_history <= 0;
        y_detect <= 1'b0;
    end else begin
        case (state)
            2'b00: begin // State A
                f_reg <= 1'b0;
                g_reg <= 1'b0;

                if (resetn && clk) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin // State B
                f_reg <= 1'b1;
                state <= 2'b10;
                x_history <= {x_history[1:0], x};

                if (resetn && clk && (x_history == 3'b101)) begin // Detect pattern 101
                    state <= 2'b11;
                end
            end
            2'b10: begin // State C
                f_reg <= 1'b0;
                g_reg <= 1'b1;

                if (resetn && clk) begin
                    state <= 2'b00;
                end

                if (resetn && clk && (y == 1'b1)) begin
                    y_detect <= 1'b1;
                end
            end
            2'b11: begin // State D
                f_reg <= 1'b0;
                g_reg <= y_detect;

                if (resetn && clk) begin
                    state <= 2'b00;
                end
            end
        endcase
    end
end

assign f = f_reg;
assign g = g_reg;

endmodule
