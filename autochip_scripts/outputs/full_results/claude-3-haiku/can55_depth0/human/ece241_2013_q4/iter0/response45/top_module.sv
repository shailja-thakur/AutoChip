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
parameter STATE_HIGH = 2'b11,
          STATE_MEDIUM = 2'b10,
          STATE_LOW = 2'b00;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_LOW;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            STATE_HIGH: begin
                if (s[3]) begin
                    state <= STATE_HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= STATE_MEDIUM;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else begin
                    state <= STATE_LOW;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            
            STATE_MEDIUM: begin
                if (s[3]) begin
                    state <= STATE_HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2] && s[1]) begin
                    state <= STATE_MEDIUM;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else begin
                    state <= STATE_LOW;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end
            
            STATE_LOW: begin
                if (s[3]) begin
                    state <= STATE_HIGH;
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 0;
                    dfr <= 0;
                end
                else if (s[2]) begin
                    state <= STATE_MEDIUM;
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else if (s[1]) begin
                    state <= STATE_LOW;
                    fr3 <= 1;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 0;
                end
                else begin
                    state <= STATE_LOW;
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
