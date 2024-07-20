module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate wires
    wire[6:1] y_next;
  
    always @(y or w) begin
      // Next state logic
      case (y)
        6'b000001: begin // A
          if (w == 1'b0)
            y_next = 6'b000010; // B
          else
            y_next = 6'b000001; // A
        end
        6'b000010: begin // B
          if (w == 1'b0)
            y_next = 6'b000100; // C
          else
            y_next = 6'b000011; // D
        end
        6'b000011: begin // D
          if (w == 1'b0)
            y_next = 6'b001100; // F
          else
            y_next = 6'b000001; // A
        end
        6'b000100: begin // C
          if (w == 1'b0)
            y_next = 6'b010000; // E
          else
            y_next = 6'b000011; // D
        end
        6'b001100: begin // F
          if (w == 1'b0)
            y_next = 6'b100100; // C
          else
            y_next = 6'b000011; // D
        end
        6'b010000: begin // E
          if (w == 1'b0)
            y_next = 6'b010000; // E
          else
            y_next = 6'b000011; // D
        end
        default: y_next = 6'bxxxxxx; // Unknown state
      endcase
    end

    // Output logic
    always @(posedge clk) begin
      Y2 <= y_next[2];
      Y4 <= y_next[4];
    end

endmodule
