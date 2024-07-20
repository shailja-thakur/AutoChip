module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110;

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            S0: begin
                if (in == 1) begin
                    state <= S1;
                end
                else begin
                    state <= S0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S1: begin
                if (in == 1) begin
                    state <= S2;
                end
                else begin
                    state <= S0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S2: begin
                if (in == 1) begin
                    state <= S3;
                end
                else begin
                    state <= S0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S3: begin
                if (in == 1) begin
                    state <= S4;
                end
                else begin
                    state <= S0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S4: begin
                if (in == 1) begin
                    state <= S5;
                end
                else begin
                    state <= S0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S5: begin
                if (in == 0) begin
                    state <= S0;
                    disc <= 1;
                end
                else begin
                    state <= S6;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            S6: begin
                if (in == 1) begin
                    state <= S6;
                    err <= 1;
                end
                else begin
                    state <= S0;
                    disc <= 0;
                    flag <= 1;
                end
            end
        endcase
    end
end

endmodule
