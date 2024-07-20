module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;
parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(x, y) begin
    case (state)
        S0: begin
            z <= 1'b1;
            if (x == 1'b1 && y == 1'b0) begin
                state <= S1;
            end
        end
        S1: begin
            z <= 1'b0;
            if (x == 1'b0 && y == 1'b1) begin
                state <= S2;
            end
        end
        S2: begin
            z <= 1'b0;
            if (x == 1'b1 && y == 1'b1) begin
                state <= S3;
            end
        end
        S3: begin
            z <= 1'b1;
            if (x == 1'b0 && y == 1'b0) begin
                state <= S0;
            end
        end
        default: begin
            z <= 1'b0;
            state <= S0;
        end
    endcase
end

endmodule
