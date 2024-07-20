module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] prev_s; // to store the previous value of s

always @(posedge clk or posedge reset) begin
    if (reset) begin
        prev_s <= 3'b000; // Initial value when reset is high
        fr3 <= 1'b1; // Reset value
        fr2 <= 1'b1; // Reset value
        fr1 <= 1'b1; // Reset value
        dfr <= 1'b1; // Reset value
    end else begin
        case({prev_s, s}) // Detecting the sensor change
            2'b110: begin
                fr3 <= 1'b0; // Water level above s[3]
                fr2 <= fr2; // No change
                fr1 <= fr1; // No change
                dfr <= dfr; // No change
            end
            2'b101: begin
                fr3 <= fr3; // No change
                fr2 <= 1'b1; // Water level between s[3] and s[2]
                fr1 <= 1'b0; // Water level between s[3] and s[2]
                dfr <= dfr; // No change
            end
            2'b010: begin
                fr3 <= fr3; // No change
                fr2 <= 1'b0; // Water level between s[2] and s[1]
                fr1 <= 1'b0; // Water level between s[2] and s[1]
                dfr <= 1'b1; // Water level between s[2] and s[1], increase flow rate
            end
            2'b001: begin
                fr3 <= 1'b0; // Water level below s[1]
                fr2 <= 1'b0; // Water level below s[1]
                fr1 <= 1'b0; // Water level below s[1]
                dfr <= 1'b1; // Water level below s[1], increase flow rate
            end
            default: begin
                // Handle any other sensor combinations not mentioned in the table
                fr3 <= 1'b1; // Reset value
                fr2 <= 1'b1; // Reset value
                fr1 <= 1'b1; // Reset value
                dfr <= 1'b1; // Reset value
            end
        endcase
        prev_s <= s; // Update previous value of s
    end
end

endmodule
