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
parameter [1:0] LOW = 2'b00, MEDIUM = 2'b01, HIGH = 2'b10, MAX = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= LOW;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            LOW: begin
                if (s[1] == 1'b0) begin
                    state <= MAX;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b0) begin
                    state <= MEDIUM;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b0) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b1) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            end
            MEDIUM: begin
                if (s[1] == 1'b0) begin
                    state <= MAX;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b0) begin
                    state <= MEDIUM;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b0) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b1) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            end
            HIGH: begin
                if (s[1] == 1'b0 && s[2] == 1'b0) begin
                    state <= MAX;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b0) begin
                    state <= MEDIUM;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b0) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b1) begin
                    state <= HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
            end
            MAX: begin
                if (s[1] == 1'b1 || s[2] == 1'b1 || s[3] == 1'b1) begin
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
            default: begin
                state <= LOW;
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end
        endcase
    end
end

endmodule
