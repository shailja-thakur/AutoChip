module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:0] state;
parameter HIGH_LEVEL = 4'b1000;
parameter BETWEEN_3_AND_2_LEVEL = 4'b1100;
parameter BETWEEN_2_AND_1_LEVEL = 4'b0100;
parameter LOW_LEVEL = 4'b0000;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= LOW_LEVEL; // Reset the state machine to low level state
    end else begin
        case (state)
            HIGH_LEVEL:
                if (s === HIGH_LEVEL) begin
                    state <= HIGH_LEVEL;
                end else if (s === BETWEEN_3_AND_2_LEVEL) begin
                    state <= BETWEEN_3_AND_2_LEVEL;
                end
            BETWEEN_3_AND_2_LEVEL:
                if (s === HIGH_LEVEL) begin
                    state <= HIGH_LEVEL;
                end else if (s === BETWEEN_3_AND_2_LEVEL) begin
                    state <= BETWEEN_3_AND_2_LEVEL;
                end else if (s === BETWEEN_2_AND_1_LEVEL) begin
                    state <= BETWEEN_2_AND_1_LEVEL;
                end
            BETWEEN_2_AND_1_LEVEL:
                if (s === BETWEEN_3_AND_2_LEVEL) begin
                    state <= BETWEEN_3_AND_2_LEVEL;
                end else if (s === BETWEEN_2_AND_1_LEVEL) begin
                    state <= BETWEEN_2_AND_1_LEVEL;
                end else if (s === LOW_LEVEL) begin
                    state <= LOW_LEVEL;
                end
            LOW_LEVEL:
                if (s === BETWEEN_2_AND_1_LEVEL) begin
                    state <= BETWEEN_2_AND_1_LEVEL;
                end else if (s === LOW_LEVEL) begin
                    state <= LOW_LEVEL;
                end
        endcase
    end
end

always @(state) begin
    case (state)
        HIGH_LEVEL:
            fr1 <= 0;
            fr2 <= 0;
            fr3 <= 0;
            dfr <= 0;
        BETWEEN_3_AND_2_LEVEL:
            fr1 <= 1;
            fr2 <= 0;
            fr3 <= 0;
            dfr <= 0;
        BETWEEN_2_AND_1_LEVEL:
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 0;
            dfr <= 0;
        LOW_LEVEL:
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
    endcase
end

endmodule
