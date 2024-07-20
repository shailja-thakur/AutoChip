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
    
    always @(posedge clk) begin
        if (!resetn) begin
            f_reg <= 0;
            g_reg <= 0;
            x_reg <= 0;
            y_reg <= 0;
        end else begin
            f_reg <= 1'b0;
            g_reg <= 1'b0;
            
            if (f_reg) begin
                x_reg <= {x_reg[1:0], x};
                
                if (x_reg == 3'b101)
                    g_reg <= 1'b1;
                else if (g_reg) begin
                    y_reg <= {y_reg[0], y};
                    
                    if (y_reg == 2'b00)
                        g_reg <= 1'b0;
                    else if (y_reg == 2'b01)
                        g_reg <= 1'b1;
                end
            end else if (!f_reg)
                f_reg <= 1'b1;
        end
    end
    
    assign f = f_reg;
    assign g = g_reg;
    
endmodule
