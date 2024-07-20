module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    reg [1:0] state;
    reg f_reg, g_reg;
    reg [2:0] x_history;
    reg reset_sync;
    
    always @(posedge clk) begin
        reset_sync <= ~resetn;
        if (reset_sync) begin
            state <= 2'b0; // state A
            f_reg <= 1'b0;
            g_reg <= 1'b0;
            x_history <= 3'b0;
        end else begin
            case(state)
                2'b00: begin
                    f_reg <= 1'b1;
                    state <= 2'b01;
                end
                2'b01: begin
                    if (x_history == 3'b101) begin
                        g_reg <= 1'b1;
                        state <= 2'b10;
                    end else begin
                        x_history <= {x_history[1:0], x};
                    end
                end
                2'b10: begin
                    if (y) begin
                        g_reg <= 1'b1;
                    end else begin
                        g_reg <= 1'b0;
                        state <= 2'b00;
                    end
                end
                default: begin
                    f_reg <= 1'b0;
                    g_reg <= 1'b0;
                    state <= 2'b00;
                    x_history <= 3'b0;
                end
            endcase
        end
    end
    
    assign f = f_reg;
    assign g = g_reg;
endmodule
