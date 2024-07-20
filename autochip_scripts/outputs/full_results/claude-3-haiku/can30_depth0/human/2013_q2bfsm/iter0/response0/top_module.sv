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

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
        x_count <= 0;
    end
    else begin
        case (state)
            A: begin
                f <= 0;
                g <= 0;
                if (resetn) begin
                    state <= B;
                    f <= 1;
                end
            end
            B: begin
                f <= 0;
                if (x == 1)
                    x_count <= 1;
                else
                    x_count <= 0;
                state <= C;
            end
            C: begin
                if (x == 0)
                    x_count <= 2;
                else
                    x_count <= 0;
                state <= D;
            end
            D: begin
                if (x == 1) begin
                    g <= 1;
                    if (y == 1) begin
                        g <= 1;
                    end
                    else begin
                        state <= A;
                    end
                end
                else begin
                    g <= 0;
                end
            end
        endcase
    end
end

endmodule
