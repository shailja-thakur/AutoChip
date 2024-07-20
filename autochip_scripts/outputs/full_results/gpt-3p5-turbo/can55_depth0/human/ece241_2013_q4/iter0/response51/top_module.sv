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

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else begin
        case (state)
            2'b00: begin // Above s[3]
                if (s[3])
                    state <= 2'b01;
            end
            2'b01: begin // Between s[3] and s[2]
                if (~s[3] && s[2])
                    state <= 2'b10;
                else if (s[3])
                    state <= 2'b00;
            end
            2'b10: begin // Between s[2] and s[1]
                if (~s[2] && s[1])
                    state <= 2'b11;
                else if (s[3])
                    state <= 2'b00;
            end
            2'b11: begin // Below s[1]
                if (~s[1])
                    state <= 2'b11;
                else if (s[3])
                    state <= 2'b00;
            end
        endcase
    end
end

always @(posedge clk) begin
    case (state)
        2'b00: begin // Above s[3]
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;
        end
        2'b01: begin // Between s[3] and s[2]
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 1;
            dfr <= 0;
        end
        2'b10: begin // Between s[2] and s[1]
            fr3 <= 0;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 0;
        end
        2'b11: begin // Below s[1]
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end
    endcase
end

endmodule
