module top_module (
	input wire clk,
	input wire reset,
	input wire [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [2:0] state;

parameter ABOVE_S3 = 3'b000;
parameter BETWEEN_S3_S2 = 3'b001;
parameter BETWEEN_S2_S1 = 3'b010;
parameter BELOW_S1 = 3'b011;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= ABOVE_S3;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
    end else begin
        case(state)
            ABOVE_S3:
                if (s[3])
                    state <= BETWEEN_S3_S2;
            BETWEEN_S3_S2:
                if (s[2])
                    state <= BETWEEN_S2_S1;
                else if (!s[3])
                    state <= ABOVE_S3;
            BETWEEN_S2_S1:
                if (s[1])
                    state <= BELOW_S1;
                else if (!s[2])
                    state <= BETWEEN_S3_S2;
            BELOW_S1:
                if (!s[1])
                    state <= ABOVE_S3;
        endcase
        case(state)
            ABOVE_S3:
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            BETWEEN_S3_S2:
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            BETWEEN_S2_S1:
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            BELOW_S1:
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
        endcase
    end
end

endmodule
