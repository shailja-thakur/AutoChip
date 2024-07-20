module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    
    reg [3:1] s_reg;
    reg [1:0] level_reg;
    reg [1:0] prev_level_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            s_reg <= 3'b0;
            level_reg <= 2'b00;
            prev_level_reg <= 2'b00;
        end else begin
            s_reg <= s;
            prev_level_reg <= level_reg;
            
            case (s_reg)
                3'b111:  // Above s[3]
                    begin
                        fr3 <= 1'b0;
                        fr2 <= 1'b0;
                        fr1 <= 1'b0;
                        dfr <= 1'b0;
                        level_reg <= 2'b11;
                    end
                3'b110:  // Between s[3] and s[2]
                    begin
                        fr3 <= 1'b1;
                        fr2 <= 1'b0;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        level_reg <= 2'b10;
                    end
                3'b100:  // Between s[2] and s[1]
                    begin
                        fr3 <= 1'b1;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b0;
                        level_reg <= 2'b01;
                    end
                3'b000:  // Below s[1]
                    begin
                        fr3 <= 1'b1;
                        fr2 <= 1'b1;
                        fr1 <= 1'b1;
                        dfr <= 1'b1;
                        level_reg <= 2'b00;
                    end
                default:
                    begin
                        fr3 <= 1'b0;
                        fr2 <= 1'b0;
                        fr1 <= 1'b0;
                        dfr <= 1'b0;
                        level_reg <= 2'b00;
                    end
            endcase
            
            if (level_reg > prev_level_reg) begin
                dfr <= 1'b1;
            end else begin
                dfr <= 1'b0;
            end
        end
    end
    
endmodule
