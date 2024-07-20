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
parameter [1:0] LOW = 2'b00, MID = 2'b01, HIGH = 2'b10, RESET = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end
    else begin
        case (state)
            LOW: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
                if (s[1]) begin
                    state <= MID;
                end
                else if (s[2]) begin
                    state <= HIGH;
                end
            end
            MID: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
                if (s[2]) begin
                    state <= HIGH;
                end
                else if (!s[1]) begin
                    state <= LOW;
                end
            end
            HIGH: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
                if (!s[2]) begin
                    state <= MID;
                end
                else if (!s[3]) begin
                    state <= LOW;
                end
            end
            RESET: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
                if (s[1]) begin
                    state <= MID;
                end
                else if (s[2]) begin
                    state <= HIGH;
                end
                else begin
                    state <= LOW;
                end
            end
        endcase
    end
end

endmodule
