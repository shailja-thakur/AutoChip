module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state, next_state;
parameter LEVEL_HIGH = 2'b00, LEVEL_MID = 2'b01, LEVEL_LOW = 2'b10, LEVEL_EMPTY = 2'b11;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= LEVEL_EMPTY;
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            LEVEL_HIGH: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            LEVEL_MID: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= s[1] ? 1'b1 : 1'b0;
            end
            LEVEL_LOW: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            LEVEL_EMPTY: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase
    end
end

always @(*) begin
    // Update next state
    if (s[3]) begin
        next_state = LEVEL_HIGH;
    end
    else if (s[2]) begin
        next_state = LEVEL_MID;
    end
    else if (s[1]) begin
        next_state = LEVEL_LOW;
    end
    else begin
        next_state = LEVEL_EMPTY;
    end
end

endmodule
