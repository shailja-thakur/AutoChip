module top_module (
    input clk,
    input reset,
    input [2:0] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] prev_s;
reg [1:0] state;

parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;

always @(posedge clk) begin
    if (reset) begin
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
        state <= S0;
    end else begin
        prev_s <= s;

        case (state)
            S0: begin // Above s[3]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                
                if (s[2] == 1'b1) begin
                    state <= S1;
                end
            end
            S1: begin // Between s[3] and s[2]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                
                if (s[1] == 1'b1) begin
                    state <= S2;
                end
                
                if (s[2] == 1'b0) begin
                    state <= S0;
                end
            end
            S2: begin // Between s[2] and s[1]
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                
                if (prev_s[2] > s[2]) begin
                    dfr <= 1'b1;
                end else begin
                    dfr <= 1'b0;
                end
                
                if (s[0] == 1'b0) begin
                    state <= S3;
                end
                
                if (s[1] == 1'b0) begin
                    state <= S1;
                end
            end
            S3: begin // Below s[1]
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                
                if (s[0] == 1'b1) begin
                    state <= S2;
                end
            end
        endcase
    end
end

endmodule
