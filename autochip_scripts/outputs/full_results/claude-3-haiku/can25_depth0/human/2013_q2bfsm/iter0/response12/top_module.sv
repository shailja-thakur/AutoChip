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
                if (x == 1) begin
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
                if (x == 0) begin
                    state <= D;
                    x_count <= 1;
                end
                else begin
                    x_count <= 0;
                end
            end
            D: begin
                if (x == 1) begin
                    x_count <= x_count + 1;
                    if (x_count == 2) begin
                        g <= 1;
                        if (y == 1) begin
                            state <= D;
                        end
                        else begin
                            state <= D;
                        end
                    end
                    else begin
                        state <= D;
                    end
                end
                else begin
                    x_count <= 0;
                    state <= C;
                end
            end
        endcase
    end
end

endmodule
