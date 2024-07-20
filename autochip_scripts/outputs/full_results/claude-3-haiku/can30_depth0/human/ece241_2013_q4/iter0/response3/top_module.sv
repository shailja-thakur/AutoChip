module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

localparam ABOVE_S3 = 3'b111;
localparam BETWEEN_S3_S2 = 3'b110;
localparam BETWEEN_S2_S1 = 3'b100;
localparam BELOW_S1 = 3'b000;

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (s)
        ABOVE_S3: begin
            fr3 = 1'b0;
            fr2 = 1'b0;
            fr1 = 1'b0;
            dfr = 1'b0;
            next_state = ABOVE_S3;
        end
        BETWEEN_S3_S2: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b0;
            next_state = BETWEEN_S3_S2;
        end
        BETWEEN_S2_S1: begin
            fr3 = 1'b0;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            next_state = BETWEEN_S2_S1;
        end
        BELOW_S1: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            next_state = BELOW_S1;
        end
        default: begin
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            dfr = 1'b1;
            next_state = BELOW_S1;
        end
    endcase
end

endmodule
