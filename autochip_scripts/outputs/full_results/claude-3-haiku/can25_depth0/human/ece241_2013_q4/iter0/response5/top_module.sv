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
parameter [1:0] LOW = 2'b00, MID = 2'b01, HIGH = 2'b10, MAX = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= MAX;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            MAX: begin
                if (s[3]) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else begin
                    state <= MAX;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            HIGH: begin
                if (!s[3] && s[2]) begin
                    state <= MID;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (!s[3] && !s[2]) begin
                    state <= LOW;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            end
            MID: begin
                if (s[3]) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (!s[2] && s[1]) begin
                    state <= LOW;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= MID;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
            end
            LOW: begin
                if (s[2]) begin
                    state <= MID;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= LOW;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else begin
                    state <= MAX;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
        endcase
    end
end

endmodule
