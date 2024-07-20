module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
 
// Internal signals
reg [7:0] hh_temp;
reg [7:0] mm_temp;
reg [7:0] ss_temp;
reg [10:0] counter;

// Reset logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    counter <= 0;
    pm <= 1'b0;
    hh <= 8'b00010010;
    mm <= 8'b00000000;
    ss <= 8'b00000000;
  end else if (ena) begin
    counter <= counter + 1;
  end
end

// AM/PM indicator logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    pm <= 1'b0;
  end else if (counter >= 43200) begin
    pm <= 1'b1;
  end else begin
    pm <= 1'b0;
  end
end

// Hour counter logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    hh_temp <= 8'b00010010;
  end else if (ena && counter >= 59 && mm_temp >= 59 && ss_temp >= 59) begin
    hh_temp <= (hh_temp == 8'b00011000) ? 8'b00010001 : hh_temp + 1;
  end
end

// Minute counter logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    mm_temp <= 8'b00000000;
  end else if (ena && counter >= 59 && ss_temp >= 59) begin
    mm_temp <= (mm_temp == 8'b00011001) ? 8'b00000000 : mm_temp + 1;
  end
end

// Second counter logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    ss_temp <= 8'b00000000;
  end else if (ena && counter >= 59) begin
    ss_temp <= (ss_temp == 8'b00111011) ? 8'b00000000 : ss_temp + 1;
  end
end

// Output assignments
always @(posedge clk) begin
  hh <= hh_temp;
  mm <= mm_temp;
  ss <= ss_temp;
end

endmodule
