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
                if (x == 1 && y == 0) begin
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
                if (x == 0 && y == 0) begin
                    state <= D;
                end
            end
            D: begin
                if (x == 1 && y == 0) begin
                    g <= 1;
                    if (y == 1) begin
                        g <= 1;
                    end
                    else begin
                        g <= 0;
                    end
                end
            end
        endcase
    end
end

endmodule
