module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;
parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge x, posedge y) begin
    case (state)
        S0: begin
            z <= 1'b1;
            if (x) state <= S1;
            else if (y) state <= S2;
            else state <= S0;
        end
        S1: begin
            z <= 1'b0;
            if (x) state <= S1;
            else if (y) state <= S3;
            else state <= S0;
        end
        S2: begin
            z <= 1'b0;
            if (x) state <= S3;
            else if (y) state <= S2;
            else state <= S0;
        end
        S3: begin
            z <= 1'b1;
            if (x) state <= S1;
            else if (y) state <= S2;
            else state <= S0;
        end
    endcase
end

endmodule
