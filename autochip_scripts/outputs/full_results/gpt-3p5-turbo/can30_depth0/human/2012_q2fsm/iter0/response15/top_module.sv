module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

  reg [2:0] state;
  reg [2:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      3'b000: begin // A
        if (w) begin
          next_state = 3'b010; // B
        end else begin
          next_state = 3'b000; // A
        end
      end
      3'b010: begin // B
        if (w) begin
          next_state = 3'b100; // C
        end else begin
          next_state = 3'b011; // D
        end
      end
      3'b100: begin // C
        if (w) begin
          next_state = 3'b101; // E
        end else begin
          next_state = 3'b011; // D
        end
      end
      3'b011: begin // D
        if (w) begin
          next_state = 3'b110; // F
        end else begin
          next_state = 3'b000; // A
        end
      end
      3'b101: begin // E
        if (w) begin
          next_state = 3'b101; // E
        end else begin
          next_state = 3'b011; // D
        end
      end
      3'b110: begin // F
        if (w) begin
          next_state = 3'b100; // C
        end else begin
          next_state = 3'b011; // D
        end
      end
      default: begin
        next_state = 3'b000; // A
      end
    endcase
  end

  always @(posedge clk) begin
    case (state)
      3'b000: begin // A
        z <= 1'b0;
      end
      3'b010: begin // B
        z <= 1'b0;
      end
      3'b100: begin // C
        z <= 1'b1;
      end
      3'b011: begin // D
        z <= 1'b0;
      end
      3'b101: begin // E
        z <= 1'b1;
      end
      3'b110: begin // F
        z <= 1'b0;
      end
      default: begin
        z <= 1'b0;
      end
    endcase
  end

endmodule
