module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [4:0] h_count;
    reg [5:0] m_count;
    reg [5:0] s_count;

    always @(posedge clk) begin
        if (reset) begin
            h_count <= 5'b0000;
            m_count <= 6'b000000;
            s_count <= 6'b000000;
            pm <= 1'b0;
        end else if (ena) begin
            if (s_count == 6'b101101) begin
                s_count <= 6'b000000;
                if (m_count == 6'b110011) begin
                    m_count <= 6'b000000;
                    if (h_count == 5'b1011) begin
                        h_count <= 5'b0000;
                        pm <= ~pm;
                    end else begin
                        h_count <= h_count + 5'b00001;
                    end
                end else begin
                    m_count <= m_count + 6'b000001;
                end
            end else begin
                s_count <= s_count + 6'b000001;
            end
        end
    end

    assign hh = {pm, h_count};
    assign mm = m_count;
    assign ss = s_count;
endmodule
