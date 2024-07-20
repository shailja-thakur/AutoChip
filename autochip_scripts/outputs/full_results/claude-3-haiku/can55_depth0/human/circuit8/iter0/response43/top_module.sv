module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg [1:0] state;
parameter [1:0] 
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10,
    S3 = 2'b11;

always @(posedge clock) begin
    case (state)
        S0: begin
            p <= 0;
            q <= 0;
            if (a == 0) begin
                state <= S0;
            end else begin
                state <= S1;
            end
        end
        S1: begin
            p <= 0;
            q <= 0;
            state <= S2;
        end
        S2: begin
            p <= 0;
            q <= 0;
            state <= S3;
        end
        S3: begin
            p <= 1;
            q <= 0;
            if (a == 0) begin
                state <= S0;
            end else begin
                state <= S3;
            end
        end
        default: begin
            state <= S0;
        end
    endcase
end

endmodule
