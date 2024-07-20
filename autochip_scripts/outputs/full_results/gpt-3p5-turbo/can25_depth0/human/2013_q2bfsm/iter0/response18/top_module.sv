module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [1:0] state;
    reg f_temp, g_temp;
    reg g_permanent;

    always @(posedge clk) begin
        if (resetn == 0) begin
            state <= 2'b00; // State A
            f <= 0;
            g <= 0;
        end else begin
            case (state)
                2'b00: begin // State A
                    f <= 0;
                    g <= 0;

                    if (resetn == 1) begin
                        state <= 2'b01; // State B
                        f_temp <= 1;
                    end
                end
                2'b01: begin // State B
                    f <= f_temp;
                    g <= 0;

                    if (resetn == 1) begin
                        state <= 2'b10; // State C
                    end
                end
                2'b10: begin // State C
                    f <= 0;
                    g <= g_temp;

                    if (resetn == 1) begin
                        if (x == 1 && x_prev == 0) begin
                            state <= 2'b11; // State D
                        end
                    end
                end
                2'b11: begin // State D
                    f <= 0;
                    g <= g_temp;

                    if (resetn == 1) begin
                        if (x == 1 && x_prev == 0) begin
                            state <= 2'b11; // Stay in State D
                            if (y == 1) begin
                                g_temp <= 1;
                                g_permanent <= 1;
                            end else if (y == 0 && y_prev == 1) begin
                                g_temp <= 0;
                                g_permanent <= 0;
                            end
                        end else begin
                            state <= 2'b10; // Go back to State C
                        end
                    end
                end
            endcase
        end
    end

    reg x_prev, y_prev;
    always @(posedge clk) begin
        x_prev <= x;
        y_prev <= y;
    end

endmodule
