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
    reg x_reg[2:0];
    reg y_reg[1:0];
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f_reg <= 0;
            g_reg <= 0;
            state <= 2'b0;
            x_reg <= 3'b0;
            y_reg <= 2'b0;
        end else begin
            case (state)
                2'b00: begin
                    f_reg <= 1;
                    g_reg <= 0;
                    state <= 2'b01;
                end
                2'b01: begin
                    f_reg <= 0;
                    g_reg <= 0;
                    if (x == 1) begin
                        state <= 2'b10;
                        x_reg <= {x_reg[1:0], x};
                    end
                end
                2'b10: begin
                    f_reg <= 0;
                    g_reg <= 0;
                    if (x_reg == 3'b101) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b01;
                    end
                    x_reg <= {x_reg[1:0], x};
                end
                2'b11: begin
                    f_reg <= 0;
                    g_reg <= 1;
                    if (y == 1) begin
                        state <= 2'b11;
                        y_reg <= {y_reg[0], y};
                    end else if (y_reg == 2'b01) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b01;
                    end
                end
            endcase
        end
    end
    
    assign f = f_reg;
    assign g = g_reg;
    
endmodule
