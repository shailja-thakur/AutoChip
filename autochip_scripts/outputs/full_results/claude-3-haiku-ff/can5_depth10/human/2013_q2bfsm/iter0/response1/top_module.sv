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

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
    end
    else begin
        case (state)
            A: begin
                f <= 0;
                g <= 0;
                if (x == 1 && y == 0)
                    state <= B;
            end
            B: begin
                f <= 1;
                g <= 0;
                state <= C;
            end
            C: begin
                f <= 0;
                if (x == 0 && y == 0)
                    state <= D;
                else
                    state <= C;
            end
            D: begin
                f <= 0;
                if (x == 1 && y == 0)
                    state <= D;
                else if (y == 1)
                    state <= D;
                else
                    state <= A;
                g <= (y == 1) ? 1 : 0;
            end
        endcase
    end
end

endmodule
