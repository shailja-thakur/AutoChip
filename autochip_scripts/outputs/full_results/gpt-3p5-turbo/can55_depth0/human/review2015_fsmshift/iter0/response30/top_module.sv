module top_module(
    input clk,
    input reset,
    output shift_ena);

  reg [31:0] counter;
  reg enable;
  reg [3:0] pattern;
  reg [3:0] shift_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 0;
      enable <= 1;
    end else begin
      if (enable) begin
        if (counter < 4) begin
          counter <= counter + 1;
          shift_ena <= 1;
        end else begin
          counter <= 0;
          enable <= 0;
          shift_ena <= 0;
        end
      end else begin
        shift_ena <= 0;
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      shift_count <= 0;
    end else begin
      if (shift_ena) begin
        shift_count <= shift_count + 1;
      end else begin
        shift_count <= 0;
      end
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      pattern <= 0;
    end else begin
      if (shift_count == 0) begin
        pattern <= 4'b1101;
      end else if (shift_count == 1) begin
        pattern <= 4'b1011;
      end else if (shift_count == 2) begin
        pattern <= 4'b0111;
      end else if (shift_count == 3) begin
        pattern <= 4'b1110;
      end else begin
        pattern <= 0;
      end
    end
  end

endmodule
