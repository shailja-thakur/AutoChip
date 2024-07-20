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
    reg [2:0] x_reg;
    reg [1:0] y_reg;
    reg reset_q;

    always @(posedge clk) begin
        if (!resetn) begin
            f_reg <= 0;
            g_reg <= 0;
            x_reg <= 0;
            y_reg <= 0;
            reset_q <= 1;
        end else if (resetn && reset_q) begin
            reset_q <= 0;
            f_reg <= 1;
        end else begin
            if (x_reg == 3'b101 && g_reg == 0)
                f_reg <= 1;
            else
                f_reg <= 0;
            
            if (g_reg) begin
                if (y_reg == 2'b01)
                    g_reg <= 1;
                else if (y_reg == 2'b00)
                    g_reg <= 0;
            end else begin
                if (x_reg == 3'b101)
                    g_reg <= 1;
            end
            
            x_reg <= {x_reg[1:0], x};
            y_reg <= {y_reg[0], y};
        end
    end

    assign f = f_reg;
    assign g = g_reg;

endmodule
