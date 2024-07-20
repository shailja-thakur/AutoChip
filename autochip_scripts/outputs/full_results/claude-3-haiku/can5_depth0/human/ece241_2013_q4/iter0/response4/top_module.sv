module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] current_level;
reg [1:0] prev_level;

always @(posedge clk) begin
    if (reset) begin
        current_level <= 2'b00;
        prev_level <= 2'b00;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end
    else begin
        if (s[3]) begin
            current_level <= 2'b11;
        end
        else if (s[2]) begin
            current_level <= 2'b10;
        end
        else if (s[1]) begin
            current_level <= 2'b01;
        end
        else begin
            current_level <= 2'b00;
        end

        if (current_level > prev_level) begin
            dfr <= 1'b1;
        end
        else begin
            dfr <= 1'b0;
        end

        case (current_level)
            2'b11: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
            end
            2'b10: begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
            end
            2'b01: begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
            2'b00: begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
        endcase

        prev_level <= current_level;
    end
end

endmodule
