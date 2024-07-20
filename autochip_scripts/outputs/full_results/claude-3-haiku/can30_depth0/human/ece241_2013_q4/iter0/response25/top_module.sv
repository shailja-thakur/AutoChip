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
    LOW = 2'b00,
    MID = 2'b01,
    HIGH = 2'b10,
    ABOVE_MAX = 2'b11;

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
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
                if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b0) begin
                    state <= MID;
                end
                else if (s[1] == 1'b0 && s[2] == 1'b0 && s[3] == 1'b0) begin
                    state <= ABOVE_MAX;
                end
            end
            MID: begin
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
                if (s[1] == 1'b0 && s[2] == 1'b0 && s[3] == 1'b1) begin
                    state <= HIGH;
                end
                else if (s[1] == 1'b0 && s[2] == 1'b0 && s[3] == 1'b0) begin
                    state <= ABOVE_MAX;
                end
            end
            HIGH: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= 0;
                if (s[1] == 1'b0 && s[2] == 1'b0 && s[3] == 1'b0) begin
                    state <= ABOVE_MAX;
                end
            end
            ABOVE_MAX: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
                if (s[1] == 1'b1 && s[2] == 1'b1 && s[3] == 1'b1) begin
                    state <= LOW;
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
