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

always @(posedge clk) begin
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
                    f <= 1; // Set f to 1 for one clock cycle
                end
            end
            B: begin
                f <= 0;
                if (x == 1) begin
                    x_count <= 1;
                    state <= C;
                end
                else begin
                    x_count <= 0;
                end
            end
            C: begin
                if (x == 0) begin
                    x_count <= 2;
                    state <= D;
                end
                else begin
                    x_count <= 0;
                    state <= B;
                end
            end
            D: begin
                if (x == 1) begin
                    g <= 1; // Set g to 1
                    if (y == 1) begin
                        // Maintain g = 1 permanently
                    end
                    else if (y == 0) begin
                        // Set g = 0 permanently
                        g <= 0;
                    end
                end
                else begin
                    x_count <= 0;
                    state <= B;
                end
            end
        endcase
    end
end

endmodule
