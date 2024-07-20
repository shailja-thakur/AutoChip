module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
); 

    reg f_reg, g_reg;
    reg [2:0] state;
    reg x_reg [2:0];
    reg y_reg [2:0];
    
    always @(posedge clk or negedge resetn)
    begin
        if (~resetn)
        begin
            f_reg <= 0;
            g_reg <= 0;
            state <= 0;
            x_reg <= 0;
            y_reg <= 0;
        end
        else
        begin
            case (state)
                0: // State A
                    begin
                        f_reg <= 0;
                        g_reg <= 0;
                        
                        if (resetn)
                            state <= 1;
                    end
                1: // State B
                    begin
                        f_reg <= 1;
                        state <= 2;
                    end
                2: // State C
                    begin
                        x_reg <= {x_reg[1:0], x};
                        
                        if (x_reg == 3'b101)
                        begin
                            g_reg <= 1;
                            state <= 3;
                        end
                    end
                3: // State D
                    begin
                        y_reg <= {y_reg[1:0], y};
                        
                        if (y_reg == 3'b001)
                            g_reg <= 1;
                        else if (y_reg[2] == 1'b1)
                            g_reg <= 0;
                    end
            endcase
        end
    end
    
    assign f = f_reg;
    assign g = g_reg;
    
endmodule
