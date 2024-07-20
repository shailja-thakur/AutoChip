module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
        f <= 0;
    end else begin
        case (state)
            A: begin
                if (resetn) begin
                    state <= B;
                    f <= 1;
                end
            end
            B: begin
                if (x == 1) begin
                    state <= C;
                    f <= 0;
                end
            end
            C: begin
                if (x == 0) begin
                    state <= D;
                    f <= 0;
                end
            end
            D: begin
                if (x == 1) begin
                    state <= D;
                    f <= 0;
                    if (y == 1) begin
                        g <= 1;
                    end else begin
                        g <= 0;
                    end
                end else begin
                    state <= B;
                    f <= 1;
                    g <= 0;
                end
            end
        endcase
    end
end

endmodule
