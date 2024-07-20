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
reg [1:0] x_history;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
        f <= 0;
        g <= 0;
        x_history <= 2'b00;
    end
    else begin
        case (state)
            A: begin
                f <= 0;
                g <= 0;
                if (x == 1'b1) begin
                    state <= B;
                    x_history <= {x_history[0], x};
                end
                else begin
                    x_history <= {x_history[0], x};
                end
            end
            B: begin
                f <= 1;
                g <= 0;
                state <= C;
                x_history <= {x_history[0], x};
            end
            C: begin
                f <= 0;
                if (x_history == 2'b10) begin
                    state <= D;
                end
                x_history <= {x_history[0], x};
            end
            D: begin
                if (y == 1'b1) begin
                    g <= 1;
                end
                else if (x_history == 2'b01) begin
                    g <= 0;
                end
                x_history <= {x_history[0], x};
            end
            default: begin
                state <= A;
                f <= 0;
                g <= 0;
                x_history <= 2'b00;
            end
        endcase
    end
end

endmodule
