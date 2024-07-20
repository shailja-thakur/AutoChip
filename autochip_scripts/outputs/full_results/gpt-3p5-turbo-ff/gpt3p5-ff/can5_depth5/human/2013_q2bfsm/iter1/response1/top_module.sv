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
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f_reg <= 1'b0;
            g_reg <= 1'b0;
            x_reg <= 3'b0;
            y_reg <= 2'b0;
        end else begin
            f_reg <= 1'b0;
            g_reg <= g_reg;
            x_reg <= {x_reg[1:0], x};
            y_reg <= {y_reg[0], y};
            
            if (f_reg == 1'b0) begin
                f_reg <= 1'b1;
            end else if (g_reg == 1'b1) begin
                if (y_reg == 2'b01) begin
                    f_reg <= 1'b0;
                    g_reg <= 1'b1;
                end else if (y_reg == 2'b00) begin
                    g_reg <= 1'b0;
                end
            end
        end
    end
    
    assign f = f_reg;
    assign g = g_reg;
    
endmodule
