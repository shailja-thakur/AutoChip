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
    reg x_seq;
    reg [2:0] x_count;
    reg y_seq;
    reg [1:0] y_count;
    
    always @(posedge clk) begin
        if (!resetn) begin
            f_reg <= 0;
            g_reg <= 0;
            x_reg <= 0;
            y_reg <= 0;
            x_seq <= 0;
            x_count <= 0;
            y_seq <= 0;
            y_count <= 0;
        end else begin
            f_reg <= (f_reg == 1'b0) ? 1'b1 : 1'b0;
            g_reg <= (g_reg == 1'b0) ? 1'b1 : 1'b0;
            
            case (x_seq)
                0: begin
                    if (x == 1'b1)
                        x_seq <= 1;
                    else
                        x_seq <= 0;
                end
                1: begin
                    if (x == 1'b0)
                        x_seq <= 2;
                    else
                        x_seq <= 0;
                end
                2: begin
                    if (x == 1'b1)
                        x_seq <= 0;
                    else
                        x_seq <= 0;
                end
            endcase
            
            if (x_seq == 2 && x_count != 3)
                x_count <= x_count + 1;
            else
                x_count <= 0;
            
            if (y_seq == 0 && y == 1'b1)
                y_seq <= 1;
            else if (y_seq == 1 && y_count != 2)
                y_seq <= 1;
            else
                y_seq <= 0;
            
            if (y_seq == 1 && y_count != 2)
                y_count <= y_count + 1;
            else
                y_count <= 0;
            
            if (x_seq == 2 && x_count == 3)
                g_reg <= 1'b1;
            else if (g_reg == 1'b1 && y_seq == 1 && y_count == 2)
                g_reg <= 1'b1;
            else if (g_reg == 1'b1 && y_seq == 0)
                g_reg <= 1'b0;
        end
    end
    
    assign f = f_reg;
    assign g = g_reg;
    
endmodule
