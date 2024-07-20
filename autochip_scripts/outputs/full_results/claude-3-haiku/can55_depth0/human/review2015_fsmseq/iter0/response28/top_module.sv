module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;
parameter [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            S0: begin
                if (data == 1'b1)
                    state <= S1;
                else
                    state <= S0;
            end
            S1: begin
                if (data == 1'b1)
                    state <= S2;
                else
                    state <= S0;
            end
            S2: begin
                if (data == 1'b0)
                    state <= S3;
                else
                    state <= S0;
            end
            S3: begin
                if (data == 1'b1)
                    state <= S4;
                else
                    state <= S0;
            end
            S4: begin
                start_shifting <= 1'b1;
                state <= S4;
            end
            default: begin
                state <= S0;
                start_shifting <= 1'b0;
            end
        endcase
    end
end

endmodule
