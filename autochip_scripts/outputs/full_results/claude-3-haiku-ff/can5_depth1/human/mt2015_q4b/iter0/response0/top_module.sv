module top_module(
    input x,
    input y,
    output reg z
);

reg [1:0] state;
parameter [1:0] 
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11;

always @(posedge x or posedge y) begin
    case (state)
        S0: begin
            z <= 1;
            if (x) begin
                state <= S1;
            end else if (y) begin
                state <= S2;
            end
        end
        S1: begin
            z <= 0;
            if (~x) begin
                state <= S2;
            end
        end
        S2: begin
            z <= 0;
            if (y) begin
                state <= S3;
            end
        end
        S3: begin
            z <= 1;
            if (~y) begin
                state <= S0;
            end
        end
    endcase
end

endmodule
