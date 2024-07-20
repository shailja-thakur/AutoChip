module top_module (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

  always @* begin
    case (state)
      4'b0001: begin
        if (in == 1'b0) begin
          next_state = 4'b0001;
        end
        else begin
          next_state = 4'b0010;
        end
        out = 1'b0;
      end
      
      4'b0010: begin
        if (in == 1'b0) begin
          next_state = 4'b0100;
        end
        else begin
          next_state = 4'b0010;
        end
        out = 1'b0;
      end
      
      4'b0100: begin
        if (in == 1'b0) begin
          next_state = 4'b0001;
        end
        else begin
          next_state = 4'b1000;
        end
        out = 1'b0;
      end
      
      4'b1000: begin
        if (in == 1'b0) begin
          next_state = 4'b0100;
        end
        else begin
          next_state = 4'b0010;
        end
        out = 1'b1;
      end
      
      default: begin
        next_state = 4'bxxxx;
        out = 1'bx;
      end
    endcase
  end

endmodule
