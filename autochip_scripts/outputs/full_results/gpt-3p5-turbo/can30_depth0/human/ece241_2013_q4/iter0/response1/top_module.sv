module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000; // state equivalent to low water level for a long time
        else begin
            case (state)
                3'b000: begin // Below s[1]
                    if (!s[1])
                        state <= 3'b101; // Above s[3]
                end
                3'b001: begin // Between s[2] and s[1]
                    if (s[2])
                        state <= 3'b000; // Below s[1]
                end
                3'b010: begin // Between s[3] and s[2]
                    if (s[1])
                        state <= 3'b001; // Between s[2] and s[1]
                end
                3'b100: begin // Above s[3]
                    if (s[3])
                        state <= 3'b010; // Between s[3] and s[2]
                end
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            3'b000: begin // Below s[1]
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            3'b001: begin // Between s[2] and s[1]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            3'b010: begin // Between s[3] and s[2]
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            3'b100: begin // Above s[3]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            default: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase
    end

endmodule
