module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state <= '000;
        end else begin
            case (state)
                '000:
                    if (s[1] == 1 && s[2] == 1 && s[3] == 1) begin
                        state <= '000;
                    end else if (s[1] == 1 && s[2] == 1) begin
                        state <= '001;
                    end else if (s[1] == 1) begin
                        state <= '010;
                    end else begin
                        state <= '011;
                    end
                '001:
                    if (s[1] == 0 && s[2] == 1) begin
                        state <= '000;
                    end else begin
                        state <= '001;
                    end
                '010:
                    if (s[1] == 0) begin
                        state <= '000;
                    end else begin
                        state <= '010;
                    end
                '011:
                    if (s[1] == 0 && s[2] == 0) begin
                        state <= '000;
                    end else begin
                        state <= '011;
                    end
            endcase
        end
    end

    assign fr3 = (state == '000);
    assign fr2 = (state == '001);
    assign fr1 = (state == '010);
    assign dfr = (state == '011);
endmodule