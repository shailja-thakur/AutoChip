module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] level;

// State machine
always @(posedge clk) begin
    if (reset) begin
        level <= 3'b000; // Reset to the lowest level
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (level)
            3'b000: begin // Below s[1]
                if (s[1])
                    level <= 3'b001; // Transition to between s[1] and s[2]
                else begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b1;
                end
            end
            3'b001: begin // Between s[1] and s[2]
                if (s[2])
                    level <= 3'b010; // Transition to between s[2] and s[3]
                else begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            3'b010: begin // Between s[2] and s[3]
                if (s[3])
                    level <= 3'b011; // Transition to above s[3]
                else begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            3'b011: begin // Above s[3]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
                if (!s[3])
                    level <= 3'b010; // Transition to between s[2] and s[3]
            end
        endcase
    end
end

endmodule
