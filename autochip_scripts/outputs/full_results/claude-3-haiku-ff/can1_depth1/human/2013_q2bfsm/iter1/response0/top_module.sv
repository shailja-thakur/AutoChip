module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
reg [1:0] x_count;
reg [1:0] y_count;

always @(posedge clk) begin
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
        x_count <= 0;
        y_count <= 0;
    end
    else begin
        case (state)
            A: begin
                f <= 0;
                g <= 0;
                if (resetn) begin
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
                if (x == 1) begin
                    x_count <= x_count + 1;
                end
                else begin
                    x_count <= 0;
                end
                if (x_count == 2'b10) begin
                    state <= D;
                    y_count <= 0;
                end
                else begin
                    state <= C;
                end
            end
            D: begin
                g <= 1;
                if (y == 1) begin
                    y_count <= y_count + 1;
                end
                else begin
                    y_count <= 0;
                end
                if (y_count == 2'b10) begin
                    g <= 1;
                end
                else begin
                    g <= 0;
                end
            end
        endcase
    end
end

endmodule
