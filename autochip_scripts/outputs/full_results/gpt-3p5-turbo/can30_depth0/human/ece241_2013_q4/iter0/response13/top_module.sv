module top_module (
	input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] curr_level;
reg [1:0] prev_level;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        curr_level <= 0;
        prev_level <= 0;
    end else begin
        case(s)
            0:
                curr_level <= 0;
                prev_level <= 0;
            1:
                curr_level <= 1;
                prev_level <= 0;
            2:
                curr_level <= 2;
                prev_level <= 1;
            3:
                curr_level <= 3;
                prev_level <= 2;
        endcase
    end
end

always @(curr_level, prev_level) begin
    case({curr_level, prev_level})
        {2'b00, 2'b00}:
            begin
                fr1 <= 1;
                fr2 <= 1;
                fr3 <= 1;
                dfr <= 0;
            end
        {2'b01, 2'b00}:
            begin
                fr1 <= 1;
                fr2 <= 1;
                fr3 <= 0;
                dfr <= 0;
            end
        {2'b10, 2'b01}:
            begin
                fr1 <= 1;
                fr2 <= 0;
                fr3 <= 0;
                dfr <= 1;
            end
        {2'b11, 2'b10}:
            begin
                fr1 <= 0;
                fr2 <= 0;
                fr3 <= 0;
                dfr <= 1;
            end
        default:
            begin
                fr1 <= 0;
                fr2 <= 0;
                fr3 <= 0;
                dfr <= 0;
            end
    endcase
end

endmodule
