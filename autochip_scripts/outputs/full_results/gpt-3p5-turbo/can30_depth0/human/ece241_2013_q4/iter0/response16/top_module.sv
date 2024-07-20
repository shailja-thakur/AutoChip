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
        prev_s <= 3'b000;
        fr3 <= 1;
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 1;
    end else begin
        case (s)

            3'b000: begin
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
            end

            3'b010: begin
                if (prev_s < s) begin
                    fr3 <= 0;
                    fr2 <= 0;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end

            3'b011: begin
                if (prev_s < s) begin
                    fr3 <= 0;
                    fr2 <= 1;
                    fr1 <= 1;
                    dfr <= 1;
                end
            end

            3'b111: begin
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 1;
            end

        endcase

        prev_s <= s;
    end
end

endmodule
