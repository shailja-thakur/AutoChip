module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg [1:0] state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clock) begin
    case (state)
        S0: begin
            if (a == 0) begin
                state <= S0;
                p <= 0;
                q <= 0;
            end else begin
                state <= S1;
                p <= 0;
                q <= 0;
            end
        end
        S1: begin
            state <= S2;
            p <= 0;
            q <= 0;
        end
        S2: begin
            state <= S3;
            p <= 0;
            q <= 0;
        end
        S3: begin
            if (a == 0) begin
                state <= S0;
                p <= 0;
                q <= 1;
            end else begin
                state <= S1;
                p <= 1;
                q <= 0;
            end
        end
    endcase
end

endmodule
