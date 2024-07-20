module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [3:0] state;
parameter S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, S8 = 4'd8;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        z <= 0;
    end
    else begin
        case (state)
            S0: begin
                if (x) state <= S1;
                else state <= S0;
                z <= 0;
            end
            S1: begin
                if (x) state <= S2;
                else state <= S1;
                z <= 1;
            end
            S2: begin
                if (x) state <= S3;
                else state <= S2;
                z <= 0;
            end
            S3: begin
                if (x) state <= S4;
                else state <= S3;
                z <= 1;
            end
            S4: begin
                if (x) state <= S5;
                else state <= S4;
                z <= 0;
            end
            S5: begin
                if (x) state <= S6;
                else state <= S5;
                z <= 1;
            end
            S6: begin
                if (x) state <= S7;
                else state <= S6;
                z <= 0;
            end
            S7: begin
                if (x) state <= S8;
                else state <= S7;
                z <= 1;
            end
            S8: begin
                if (x) state <= S0;
                else state <= S8;
                z <= 0;
            end
        endcase
    end
end

endmodule
