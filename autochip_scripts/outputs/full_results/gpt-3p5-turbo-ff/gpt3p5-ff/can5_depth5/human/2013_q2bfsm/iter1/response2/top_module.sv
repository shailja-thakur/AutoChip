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
    wire reset;
    
    assign reset = ~resetn;
    
    always @(posedge clk) begin
        if (reset) begin
            f_reg <= 0;
            g_reg <= 0;
            x_reg <= 0;
            y_reg <= 0;
        end else begin
            case ({x_reg, x})
                3'b101: begin 
                    f_reg <= 1;
                    g_reg <= 1;
                end
            endcase
            
            if (g_reg) begin
                case (y_reg)
                    2'b00: g_reg <= 0;
                    2'b01: g_reg <= 1;
                endcase
            end
            x_reg <= {x_reg[1:0], x};
            y_reg <= {y_reg[0], y};
        end
    end

    assign f = f_reg;
    assign g = g_reg;
    
endmodule
