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
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
        state <= 3'b000;
    end else begin
        prev_s <= s;

        case (state)
            3'b000: begin // Below s[1]
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
                if (s[3] && ~s[2] && ~s[1]) begin
                    state <= 3'b001; // Between s[2] and s[1]
                end else if (s[3] && s[2] && ~s[1]) begin
                    state <= 3'b010; // Between s[3] and s[2]
                end
            end
            3'b001: begin // Between s[2] and s[1]
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;

                if (prev_s[2] > s[2]) begin
                    dfr <= 1'b1;
                end else begin
                    dfr <= 1'b0;
                end
                
                if (s[3] && ~s[2] && ~s[1]) begin
                    state <= 3'b001; // Between s[2] and s[1]
                end else if (~s[3] && s[2] && ~s[1]) begin
                    state <= 3'b000; // Below s[1]
                end
            end
            3'b010: begin // Between s[3] and s[2]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                
                if (prev_s[1] > s[1]) begin
                    dfr <= 1'b1;
                end else begin
                    dfr <= 1'b0;
                end
                
                if (~s[3] && ~s[2] && s[1]) begin
                    state <= 3'b001; // Between s[2] and s[1]
                end
            end
        endcase
    end
end

endmodule
