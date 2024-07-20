module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg f;
reg g;
reg [1:0] state;
reg [2:0] x_reg;
reg [1:0] y_reg;
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
    end else begin
        case (state)
            A: begin
                f <= 0;
                g <= 0;
                if (x == 1'b1 && x_reg == 2'b01) begin
                    state <= B;
                end
            end
            B: begin
                f <= 1;
                g <= 0;
                state <= C;
            end
            C: begin
                f <= 0;
                g <= 0;
                if (x == 1'b0 && x_reg == 2'b10) begin
                    state <= D;
                end
            end
            D: begin
                f <= 0;
                g <= 0;
                if (x == 1'b1 && x_reg == 2'b11 && y == 1'b1 && y_reg == 2'b01) begin
                    g <= 1;
                    state <= D;
                end else if (y == 1'b1 && y_reg == 2'b01) begin
                    g <= 1;
                    state <= D;
                end else if (y == 1'b1 && y_reg == 2'b00) begin
                    g <= 0;
                    state <= A;
                end else if (y == 1'b0 && y_reg == 2'b01) begin
                    g <= 0;
                    state <= A;
                end
            end
        endcase
        x_reg <= {x, x_reg[1]};
        y_reg <= {y, y_reg[1]};
    end
end

endmodule
