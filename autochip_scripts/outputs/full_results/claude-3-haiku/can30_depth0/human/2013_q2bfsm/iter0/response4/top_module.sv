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
reg x_history[2:0];

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
        x_history[2:0] <= 3'b0;
    end
    else begin
        case (state)
            A: begin
                f <= 0;
                g <= 0;
                if (x_history[2:0] == 3'b101) begin
                    state <= B;
                    f <= 1;
                end
                else begin
                    x_history[2:0] <= {x_history[1:0], x};
                end
            end
            B: begin
                f <= 0;
                g <= 0;
                if (x_history[2:0] == 3'b101 && y) begin
                    state <= C;
                    g <= 1;
                end
                else if (x_history[2:0] == 3'b101 && !y) begin
                    state <= D;
                end
                else begin
                    x_history[2:0] <= {x_history[1:0], x};
                end
            end
            C: begin
                f <= 0;
                g <= 1;
            end
            D: begin
                f <= 0;
                g <= 0;
            end
        endcase
    end
end

endmodule
