module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output reg [2:0] g
);
  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk) begin
    if (resetn == 0) begin
      state <= 2'b00;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case(state)
      2'b00: begin
        if (r[2]) begin
          next_state = 2'b01;
        end else if (r[1]) begin
          next_state = 2'b10;
        end else if (r[0]) begin
          next_state = 2'b11;
        end else begin
          next_state = 2'b00;
        end
      end
      
      2'b01: begin
        if(r[1]) begin
          next_state = 2'b01;
        end else begin
          next_state = 2'b00;
        end
      end

      2'b10: begin
        if(r[2]) begin
          next_state = 2'b10;
        end else begin
          next_state = 2'b00;  
        end
      end

      2'b11: begin
        if(r[0]) begin
          next_state = 2'b11;
        end else begin
          next_state = 2'b00;
        end
      end

      default: begin
        next_state = 2'b00;
      end
    endcase
  end

  always @(state) begin
    case(state)
      2'b00: begin
        g = 3'b000;
      end
      2'b01: begin
        g = 3'b001;
      end
      2'b10: begin
        g = 3'b010;
      end
      2'b11: begin
        g = 3'b100;
      end
      default: begin
        g = 3'b000;
      end
    endcase
  end

endmodule
