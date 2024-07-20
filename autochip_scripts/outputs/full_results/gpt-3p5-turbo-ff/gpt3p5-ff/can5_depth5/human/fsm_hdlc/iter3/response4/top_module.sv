module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state;
  reg [5:0] ones_count;
  reg [2:0] error_state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      ones_count <= 6'b0;
      error_state <= 3'b000;
    end else begin
      case(state)
        3'b000: begin
          if(in) begin
            ones_count <= ones_count + 1;
            if (ones_count == 5) begin
              state <= 3'b001;
            end
          end else begin
            ones_count <= 6'b0;
          end
        end
        3'b001: begin
          if(in) begin
            ones_count <= ones_count + 1;
            if (ones_count == 6) begin
              state <= 3'b010;
              flag <= 1;
            end else if (ones_count >= 7) begin
              state <= 3'b000;
              error_state <= 3'b010;
              err <= 1;
            end
          end else begin
            state <= 3'b000;
            ones_count <= 6'b0;
            disc <= 1;
          end
        end
        3'b010: begin
          if(in) begin
            ones_count <= ones_count + 1;
            if (ones_count == 6) begin
              state <= 3'b011;
              flag <= 0;
            end else if (ones_count >= 7) begin
              state <= 3'b000;
              error_state <= 3'b100;
              err <= 1;
            end
          end else begin
            state <= 3'b000;
            ones_count <= 6'b0;
            disc <= 0;
          end
        end
        3'b011: begin
          if(in) begin
            ones_count <= ones_count + 1;
            if (ones_count == 5) begin
              state <= 3'b100;
            end
          end else begin
            state <= 3'b000;
            ones_count <= 6'b0;
          end
        end
        3'b100: begin
          if(in) begin
            ones_count <= ones_count + 1;
            if (ones_count >= 7) begin
              state <= 3'b000;
              error_state <= 3'b110;
              err <= 1;
            end
          end else begin
            state <= 3'b000;
            ones_count <= 6'b0;
          end
        end
        default: begin
          state <= 3'b000;
          ones_count <= 6'b0;
        end
      endcase
    end
  end

  always @(*) begin
    case(error_state)
      3'b010: begin
        disc <= 1;
        flag <= 0;
      end
      3'b100, 3'b110: begin
        disc <= 0;
        flag <= 0;
      end
      default: begin
        disc <= 0;
        flag <= 0;
      end
    endcase
  end

  assign err = (error_state != 3'b000);
  
endmodule
