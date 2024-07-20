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
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
        prev_s <= 3'b0;
    end else begin
        prev_s <= s;
        case (s)
            3'b111: begin
                fr3 <= 1'b0; // No flow rate
                fr2 <= 1'b0; // No flow rate
                fr1 <= 1'b0; // No flow rate
                dfr <= prev_s[2] < prev_s[3]; // Open Supplemental flow valve if previous level was lower
            end
            3'b110: begin
                fr3 <= 1'b0; // No flow rate
                fr2 <= 1'b0; // No flow rate
                fr1 <= 1'b1; // Nominal flow rate
                dfr <= prev_s[2] < prev_s[3]; // Open Supplemental flow valve if previous level was lower
            end
            3'b100: begin
                fr3 <= 1'b0; // No flow rate
                fr2 <= 1'b1; // Nominal flow rate
                fr1 <= 1'b1; // Nominal flow rate
                dfr <= prev_s[2] < prev_s[3]; // Open Supplemental flow valve if previous level was lower
            end
            3'b000: begin
                fr3 <= 1'b1; // Nominal flow rate
                fr2 <= 1'b1; // Nominal flow rate
                fr1 <= 1'b1; // Nominal flow rate
                dfr <= prev_s[2] < prev_s[3]; // Open Supplemental flow valve if previous level was lower
            end
            default: begin
                fr3 <= 1'b1; // Nominal flow rate
                fr2 <= 1'b1; // Nominal flow rate
                fr1 <= 1'b1; // Nominal flow rate
                dfr <= 1'b1; // Close Supplemental flow valve
            end
        endcase
    end
end

endmodule
