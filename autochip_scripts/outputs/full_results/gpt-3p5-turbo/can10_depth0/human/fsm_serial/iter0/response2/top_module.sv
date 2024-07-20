module top_module (
	input clk,
	input in,
	input reset,
	output done
);

  reg [2:0] state;
  reg [2:0] nextState;
  reg startBitDetected;
  reg [7:0] dataBitCounter;
  reg stopBitDetected;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      dataBitCounter <= 8'b00000000;
      startBitDetected <= 1'b0;
      stopBitDetected <= 1'b0;
    end else begin
      state <= nextState;
      startBitDetected <= 1'b0;
      stopBitDetected <= 1'b0;
    end
  end

  always @(state or in) begin
    case(state)
      3'b000: begin
        if (in == 1'b0) begin
          nextState = 3'b001;
        end else begin
          nextState = 3'b000;
        end
      end
      3'b001: begin
        if (in == 1'b0) begin
          nextState = 3'b001;
        end else begin
          nextState = 3'b010;
        end
      end
      3'b010: begin
        if (in == 1'b0) begin
          nextState = 3'b011;
        end else begin
          nextState = 3'b010;
        end
      end
      3'b011: begin
        if (in == 1'b0) begin
          nextState = 3'b100;
        end else begin
          nextState = 3'b010;
        end
      end
      3'b100: begin
        if (in == 1'b0) begin
          nextState = 3'b101;
        end else begin
          nextState = 3'b000;
        end
      end
      3'b101: begin
        if (in == 1'b1) begin
          nextState = 3'b110;
        end else begin
          nextState = 3'b000;
        end
      end
      3'b110: begin
        if (in == 1'b1) begin
          nextState = 3'b111;
          startBitDetected = 1'b1;
        end else begin
          nextState = 3'b000;
        end
      end
      3'b111: begin
        if (in == 1'b1) begin
          nextState = 3'b111;
          stopBitDetected = 1'b1;
          dataBitCounter = dataBitCounter + 1;
        end else begin
          nextState = 3'b000;
        end
      end
      default: nextState = 3'b000;
    endcase
  end

  assign done = (state == 3'b111) && stopBitDetected;

endmodule
