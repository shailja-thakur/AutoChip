module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg [1:0] current_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk) begin
    case (current_state)
        S0: begin
            if (a & ~b) begin
                current_state <= S1;
                q <= 0;
                state <= 0;
            end
            else begin
                current_state <= S0;
                q <= 0;
                state <= 0;
            end
        end
        S1: begin
            if (~a & ~b) begin
                current_state <= S2;
                q <= 0;
                state <= 0;
            end
            else begin
                current_state <= S1;
                q <= 0;
                state <= 0;
            end
        end
        S2: begin
            if (~a & b) begin
                current_state <= S3;
                q <= 1;
                state <= 1;
            end
            else begin
                current_state <= S2;
                q <= 0;
                state <= 0;
            end
        end
        S3: begin
            if (a & ~b) begin
                current_state <= S0;
                q <= 0;
                state <= 0;
            end
            else begin
                current_state <= S3;
                q <= 1;
                state <= 1;
            end
        end
        default: begin
            current_state <= S0;
            q <= 0;
            state <= 0;
        end
    endcase
end

endmodule
