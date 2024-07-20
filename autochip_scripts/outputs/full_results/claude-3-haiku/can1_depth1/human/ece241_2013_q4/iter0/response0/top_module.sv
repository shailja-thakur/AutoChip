module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state;
parameter ABOVE_3 = 2'b00,
          BETWEEN_3_2 = 2'b01,
          BETWEEN_2_1 = 2'b10,
          BELOW_1 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= BELOW_1;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            ABOVE_3: begin
                if (s[3:1] == 3'b111) begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else begin
                    state <= BETWEEN_3_2;
                end
            end
            BETWEEN_3_2: begin
                if (s[3:1] == 3'b110) begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[3:1] == 3'b100) begin
                    state <= BETWEEN_2_1;
                end
                else begin
                    state <= ABOVE_3;
                end
            end
            BETWEEN_2_1: begin
                if (s[3:1] == 3'b100) begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[3:1] == 3'b000) begin
                    state <= BELOW_1;
                end
                else begin
                    state <= BETWEEN_3_2;
                end
            end
            BELOW_1: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
        endcase
    end
end

endmodule
