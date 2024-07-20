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

always @(posedge clk or posedge reset) begin
    if (reset) begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
        prev_s <= 3'b0;
    end else begin
        prev_s <= s;
        if (s[3]) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
        end else if (s[2]) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
        end else if (s[1]) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
        end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b1;
        end
    end
end

endmodule
