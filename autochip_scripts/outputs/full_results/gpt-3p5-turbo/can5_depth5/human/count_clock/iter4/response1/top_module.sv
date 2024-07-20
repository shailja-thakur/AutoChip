module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

  reg [7:0] hh_next;
  reg [7:0] mm_next;
  reg [7:0] ss_next;
  reg [23:0] count = 0;
  reg [1:0] state = 0;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
      count <= 0;
    end else begin
      case (state)
        0: begin  // Idle state
          if (ena) begin
            state <= 1;  // Transition to increment state
          end
        end
        1: begin  // Increment state
          ss_next = ss + 1;
          mm_next = mm;
          hh_next = hh;
      
          if (ss_next == 8'b01101000) begin
            ss_next <= 8'b00000000;  // Reset seconds to 0
            mm_next <= mm + 1;      // Increment minutes
            if (mm_next == 8'b01101000) begin
              mm_next <= 8'b00000000;  // Reset minutes to 0
              hh_next <= hh + 1;      // Increment hours
              if (hh_next == 8'b00011010) begin
                hh_next <= 8'b00000001;  // Reset hours to 1 AM
                pm <= ~pm;          // Toggle AM/PM indicator
              end else if (hh_next == 8'b00010010) begin
                hh_next <= 8'b00000001;  // Reset hours to 1 PM
                pm <= ~pm;          // Toggle AM/PM indicator
              end
            end
          end
          
          ss <= ss_next;
          mm <= mm_next;
          hh <= hh_next;

          count <= count + 1;

          if (count == 24_000_000) begin
            state <= 0;  // Transition back to idle state
            count <= 0;
          end
        end
      endcase
    end
  end

endmodule
