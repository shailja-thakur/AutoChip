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
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
    end else begin
        case(s)
            3'b111: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            
            3'b110: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            
            3'b100: begin
                fr3 <= 1'b1;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            
            3'b000: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            
            default: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
        endcase
        prev_s <= s;
    end
end

endmodule
