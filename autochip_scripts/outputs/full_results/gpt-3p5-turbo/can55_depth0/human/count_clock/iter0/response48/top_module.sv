module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [7:0] hh_count;
  reg [7:0] mm_count;
  reg [7:0] ss_count;

  always @(posedge clk) begin
    if (reset) begin
      hh_count <= 8'd12;
      mm_count <= 8'd0;
      ss_count <= 8'd0;
      pm <= 1'b0;
    end else if (ena) begin
      ss_count <= ss_count + 1;
      if (ss_count == 8'd60) begin
        ss_count <= 8'd0;
        mm_count <= mm_count + 1;
        if (mm_count == 8'd60) begin
          mm_count <= 8'd0;
          hh_count <= hh_count + 1;
          if (hh_count == 8'd13) begin
            hh_count <= 8'd1;
            pm <= ~pm;
          end
        end
      end
    end
  end

  assign hh = {4'h0, pm, hh_count};
  assign mm = {4'h0, mm_count};
  assign ss = {4'h0, ss_count};

endmodule
