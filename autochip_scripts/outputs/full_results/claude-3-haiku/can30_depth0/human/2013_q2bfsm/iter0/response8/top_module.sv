module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

reg [1:0] state;
parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

always @(posedge clk, negedge resetn) begin
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
                if (resetn) state <= B;
            end
            B: begin
                f <= 1;
                g <= 0;
                state <= C;
            end
            C: begin
                f <= 0;
                if (x == 1) state <= D;
                else state <= C;
            end
            D: begin
                if (x == 0) state <= E;
                else state <= D;
            end
            E: begin
                if (x == 1) begin
                    g <= 1;
                    state <= F;
                end
                else state <= E;
            end
            F: begin
                if (y == 1) begin
                    g <= 1;
                    state <= F;
                end
                else if (y == 0) begin
                    g <= 0;
                    state <= F;
                end
            end
            default: state <= A;
        endcase
    end
end

endmodule
