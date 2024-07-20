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
parameter S_HIGH = 2'b11, S_MID = 2'b10, S_LOW = 2'b01, S_RESET = 2'b00;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_RESET;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            S_HIGH: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            S_MID: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            S_LOW: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            S_RESET: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            default: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
        endcase

        if (s[3]) begin
            state <= S_HIGH;
        end
        else if (s[2]) begin
            state <= S_MID;
        end
        else if (s[1]) begin
            state <= S_LOW;
        end
        else begin
            state <= S_RESET;
        end
    end
end

endmodule
