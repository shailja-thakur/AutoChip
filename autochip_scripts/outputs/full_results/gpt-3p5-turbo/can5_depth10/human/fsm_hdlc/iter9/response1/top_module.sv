module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

  reg [1:0] state;
  reg [1:0] next_state;
  wire [4:0] ones_count;
  reg check_err;

  counter_module counter (
    .clk(clk),
    .reset(reset),
    .in(in),
    .count(ones_count)
  );

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      next_state <= 2'b00;
      disc <= 1'b0;
      flag <= 1'b0;
    end else begin
      state <= next_state;
      case (state)
        2'b00: begin // State_0: Waiting for first consecutive 0 in flag pattern
          next_state <= (in == 1'b0) ? 2'b01 : 2'b00;
        end
        2'b01: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
          next_state <= (ones_count == 5'b11110) ? 2'b11 : 
                        (ones_count >= 5'b11111) ? 2'b10 : 2'b01;
        end
        2'b10: begin // State_2: Detected 7 or more consecutive 1s (error)
          next_state <= (in == 1'b0) ? 2'b00 : 2'b10;
        end
        2'b11: begin // State_3: Detected flag pattern
          next_state <= (in == 1'b0) ? 2'b00 : 2'b11;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    disc <= 0;
    flag <= 0;
    err <= 0;
    case (state)
      2'b01: disc <= (ones_count == 5'b11110);
      2'b10: err <= 1;
      2'b11: flag <= 1;
    endcase
  end
endmodule
module counter_module (
    input clk,
    input reset,
    input in,
    output reg [4:0] count
  );
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 5'b0;
    else if (in == 1'b1)
      count <= count + 1'b1;
    else
      count <= 5'b0;
  end
endmodule
