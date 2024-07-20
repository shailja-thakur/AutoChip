module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal Registers
    reg [3:0] h_tens = 4'b0;  // Tens place for hours (0-1)
    reg [3:0] h_ones = 4'b0;  // Ones place for hours (1-9)
    reg [3:0] m_tens = 4'b0;  // Tens place for minutes (0-5)
    reg [3:0] m_ones = 4'b0;  // Ones place for minutes (0-9)
    reg [3:0] s_tens = 4'b0;  // Tens place for seconds (0-5)
    reg [3:0] s_ones = 4'b0;  // Ones place for seconds (0-9)
    reg [1:0] period = 2'b00; // 00 for AM, 01 for PM

    // Update outputs
    always @(*) begin
        hh = {h_tens, h_ones};
        mm = {m_tens, m_ones};
        ss = {s_tens, s_ones};
    end

    // PM signal
    always @(*) begin
        pm = (period == 2'b01);
    end

    // Synchronous Reset and Counter Logic
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00 AM
            h_tens <= 4'h1;
            h_ones <= 4'h2;
            m_tens <= 4'h0;
            m_ones <= 4'h0;
            s_tens <= 4'h0;
            s_ones <= 4'h0;
            period <= 2'b00;
        end else if (ena) begin
            // Increment seconds
            if (s_ones == 4'd9) begin
                s_ones <= 4'd0;
                if (s_tens == 4'd5) begin
                    s_tens <= 4'd0;

                    // Increment minutes
                    if (m_ones == 4'd9) begin
                        m_ones <= 4'd0;
                        if (m_tens == 4'd5) begin
                            m_tens <= 4'd0;

                            // Increment hours
                            if (h_ones == 4'd9) begin
                                h_ones <= 4'd0;
                                h_tens <= h_tens + 4'd1;
                            end else if (h_tens == 4'd1 && h_ones == 4'd2) begin
                                // Special case: reset to 01:00 when hours reach 12
                                h_tens <= 4'd0;
                                h_ones <= 4'd1;
                                period <= period + 2'b01;  // Toggle AM/PM
                            end else begin
                                h_ones <= h_ones + 4'd1;
                            end
                        end else begin
                            m_tens <= m_tens + 4'd1;
                        end
                    end else begin
                        m_ones <= m_ones + 4'd1;
                    end
                end else begin
                    s_tens <= s_tens + 4'd1;
                end
            end else begin
                s_ones <= s_ones + 4'd1;
            end
        end
    end
endmodule
