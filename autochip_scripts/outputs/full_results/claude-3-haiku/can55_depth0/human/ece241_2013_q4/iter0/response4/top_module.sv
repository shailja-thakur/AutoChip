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
parameter [1:0] 
    LEVEL_HIGH = 2'b00,
    LEVEL_MEDIUM = 2'b01,
    LEVEL_LOW = 2'b10,
    LEVEL_EMPTY = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= LEVEL_EMPTY;
        fr1 <= 1;
        fr2 <= 1;
        fr3 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            LEVEL_HIGH: begin
                if (s[3]) begin
                    state <= LEVEL_HIGH;
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= LEVEL_MEDIUM;
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= LEVEL_LOW;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else begin
                    state <= LEVEL_EMPTY;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
            end
            LEVEL_MEDIUM: begin
                if (s[3]) begin
                    state <= LEVEL_HIGH;
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= LEVEL_MEDIUM;
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= LEVEL_LOW;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 1;
                end
                else begin
                    state <= LEVEL_EMPTY;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
            end
            LEVEL_LOW: begin
                if (s[3]) begin
                    state <= LEVEL_HIGH;
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= LEVEL_MEDIUM;
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 1;
                end
                else if (s[1]) begin
                    state <= LEVEL_LOW;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 1;
                end
                else begin
                    state <= LEVEL_EMPTY;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
            end
            LEVEL_EMPTY: begin
                if (s[3]) begin
                    state <= LEVEL_HIGH;
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= LEVEL_MEDIUM;
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 1;
                end
                else if (s[1]) begin
                    state <= LEVEL_LOW;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    dfr <= 1;
                end
                else begin
                    state <= LEVEL_EMPTY;
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
            end
        endcase
    end
end

endmodule
