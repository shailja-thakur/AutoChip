module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

// Declare state variables
reg [1:0] state;
parameter BELOW_S1 = 2'b00, BETWEEN_S1_S2 = 2'b01, BETWEEN_S2_S3 = 2'b10, ABOVE_S3 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset state to BELOW_S1
        state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        case (state)
            BELOW_S1: begin
                // Water level is below the lowest sensor s[1]
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                
                // Check if water level has risen
                if (s[1]) begin
                    state <= BETWEEN_S1_S2;
                end
            end
            BETWEEN_S1_S2: begin
                // Water level is between s[1] and s[2]
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                
                // Check if water level has risen or fallen
                if (s[2]) begin
                    state <= BETWEEN_S2_S3;
                end
                else if (!s[1]) begin
                    state <= BELOW_S1;
                end
            end
            BETWEEN_S2_S3: begin
                // Water level is between s[2] and s[3]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
                
                // Check if water level has risen or fallen
                if (s[3]) begin
                    state <= ABOVE_S3;
                end
                else if (!s[2]) begin
                    state <= BETWEEN_S1_S2;
                end
            end
            ABOVE_S3: begin
                // Water level is above the highest sensor s[3]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                
                // Check if water level has fallen
                if (!s[3]) begin
                    state <= BETWEEN_S2_S3;
                end
            end
        endcase
    end
end

endmodule
