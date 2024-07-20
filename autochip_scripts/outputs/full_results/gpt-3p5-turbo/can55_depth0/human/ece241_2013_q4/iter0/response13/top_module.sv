module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] prev_s;

always @(posedge clk) begin
    if (reset) begin
        // Reset state machine
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        if (s[3]) begin
            // Above s[3]
            prev_s <= s;
            fr3 <= 1'b0;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else if (s[2]) begin
            // Between s[3] and s[2]
            prev_s <= s;
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else if (s[1]) begin
            // Between s[2] and s[1]
            prev_s <= s;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
        end else begin
            // Below s[1]
            if (prev_s[3] > s[3]) begin
                dfr <= 1'b1;
            end else begin
                dfr <= 1'b0;
            end
            prev_s <= s;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
        end
    end
end

endmodule
