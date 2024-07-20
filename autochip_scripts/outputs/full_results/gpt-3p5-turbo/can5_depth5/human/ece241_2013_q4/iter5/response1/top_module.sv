module top_module (
    input clk,
    input reset,
    input [2:0] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
        end else begin
            case (state)
                2'b11: begin // Above s[3]
                    if (s[2]) begin // Between s[3] and s[2]
                        fr3 <= 1'b0;
                        fr2 <= 1'b0;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        state <= 2'b10;
                    end else if (s[1]) begin // Between s[2] and s[1]
                        fr3 <= 1'b0;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        state <= 2'b01;
                    end else begin // No sensors asserted
                        fr3 <= 1'b0;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b1;
                        state <= 2'b01;
                    end
                end
                2'b10: begin // Between s[3] and s[2]
                    if (s[2]) begin // Between s[3] and s[2]
                        fr3 <= 1'b0;
                        fr2 <= 1'b0;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        state <= 2'b10;
                    end else if (s[1]) begin // Between s[2] and s[1]
                        fr3 <= 1'b0;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        state <= 2'b01;
                    end else begin // No sensors asserted
                        fr3 <= 1'b0;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b1;
                        state <= 2'b01;
                    end
                end
                default: begin // Below s[1]
                    if (s[2]) begin // Between s[3] and s[2]
                        fr3 <= 1'b0;
                        fr2 <= 1'b0;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        state <= 2'b10;
                    end else if (s[1]) begin // Between s[2] and s[1]
                        fr3 <= 1'b0;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        state <= 2'b01;
                    end else begin // No sensors asserted
                        fr3 <= 1'b1;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b1;
                        state <= 2'b00;
                    end
                end
            endcase
        end
    end

endmodule
