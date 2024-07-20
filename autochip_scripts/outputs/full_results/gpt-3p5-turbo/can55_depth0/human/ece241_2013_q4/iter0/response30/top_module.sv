module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state;
reg prev_level;
reg fr1_temp, fr2_temp, fr3_temp;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        prev_level <= 1'b0;
        fr1 <= 1'b0;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
        dfr <= 1'b0;
    end else begin
        case (state)
            2'b00: begin
                if (s[3] == 1'b1) begin
                    state <= 2'b00;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[1] == 1'b1) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin
                if (s[3] == 1'b1) begin
                    state <= 2'b00;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2] == 1'b1) begin
                    state <= 2'b10;
                    prev_level <= 1'b0;
                end
            end
            2'b10: begin
                if (s[3] == 1'b1) begin
                    state <= 2'b00;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[1] == 1'b1) begin
                    state <= 2'b11;
                    prev_level <= 1'b1;
                end
            end
            2'b11: begin
                if (s[3] == 1'b1) begin
                    state <= 2'b00;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    fr3 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[2] == 1'b1) begin
                    state <= 2'b10;
                    prev_level <= 1'b1;
                end
            end
            default: state <= 2'b00;
        endcase
    end
end


always @(state) begin
    case (state)
        2'b00: begin
            fr1 <= 1'b0;
            fr2 <= 1'b0;
            fr3 <= 1'b0;
            dfr <= 1'b0;
        end
        2'b01: begin
            fr1 <= 1'b1;
            fr2 <= 1'b0;
            fr3 <= 1'b0;
            dfr <= 1'b0;
        end
        2'b10: begin
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            fr3 <= 1'b0;
            dfr <= 1'b0;
        end
        2'b11: begin
            if (prev_level == 1'b0) begin
                fr1_temp <= 1'b1;
                fr2_temp <= 1'b0;
                fr3_temp <= 1'b0;
            end else begin
                fr1_temp <= 1'b1;
                fr2_temp <= 1'b1;
                fr3_temp <= 1'b1;
            end
        end
        default: begin
            fr1 <= 1'b0;
            fr2 <= 1'b0;
            fr3 <= 1'b0;
            dfr <= 1'b0;
        end
    endcase
end

always @(posedge clk) begin
    if (state == 2'b11) begin
        fr1 <= fr1_temp;
        fr2 <= fr2_temp;
        fr3 <= fr3_temp;
        dfr <= 1'b1;
    end
end

endmodule
