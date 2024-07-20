module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // BCD incrementers for ss, mm, and hh
    reg [3:0] s1, s0, m1, m0, h1, h0;
    
    initial begin
        hh = 8'h12;
        mm = 8'h00;
        ss = 8'h00;
        pm = 1'b0;
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end
        else if (ena) begin
            // Extract BCD digits
            s0 = ss[3:0];
            s1 = ss[7:4];
            m0 = mm[3:0];
            m1 = mm[7:4];
            h0 = hh[3:0];
            h1 = hh[7:4];
            
            // Increment seconds
            if (s0 == 4'd9) begin
                if (s1 == 4'd5) begin
                    s0 <= 4'd0;
                    s1 <= 4'd0;
                    // Increment minutes
                    if (m0 == 4'd9) begin
                        if (m1 == 4'd5) begin
                            m0 <= 4'd0;
                            m1 <= 4'd0;
                            // Increment hours
                            if ((h0 == 4'd2 && h1 == 4'd1) || (h1 == 4'd0 && h0 == 4'd9)) begin
                                h0 <= 4'd0;
                                h1 <= (h1 == 4'd1) ? 4'd0 : 4'd1;
                                // Toggle AM/PM
                                pm <= ~pm;
                            end else begin
                                if (h0 == 4'd9) begin
                                    h0 <= 4'd2;
                                end else begin
                                    h0 <= h0 + 4'd1;
                                end
                            end
                        end else begin
                            m0 <= 4'd0;
                            m1 <= m1 + 4'd1;
                        end
                    end else begin
                        m0 <= m0 + 4'd1;
                    end
                end else begin
                    s0 <= 4'd0;
                    s1 <= s1 + 4'd1;
                end
            end else begin
                s0 <= s0 + 4'd1;
            end
            
            // Update BCD values in outputs
            ss <= {s1, s0};
            mm <= {m1, m0};
            hh <= {h1, h0};
        end
    end
    
endmodule
