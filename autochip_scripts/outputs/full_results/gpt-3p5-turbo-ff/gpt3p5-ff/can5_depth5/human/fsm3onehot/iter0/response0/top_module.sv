module top_module (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

  always @* begin
    case(state)
      4'b0001: begin // State A
        if(in == 1'b0) begin
          next_state = 4'b0001; // Next state A
          out = 1'b0;
        end
        else begin
          next_state = 4'b0010; // Next state B
          out = 1'b0;
        end
      end
      
      4'b0010: begin // State B
        if(in == 1'b0) begin
          next_state = 4'b0100; // Next state C
          out = 1'b0;
        end
        else begin
          next_state = 4'b0010; // Next state B
          out = 1'b0;
        end
      end
      
      4'b0100: begin // State C
        if(in == 1'b0) begin
          next_state = 4'b0001; // Next state A
          out = 1'b0;
        end
        else begin
          next_state = 4'b1000; // Next state D
          out = 1'b0;
        end
      end
      
      4'b1000: begin // State D
        if(in == 1'b0) begin
          next_state = 4'b0100; // Next state C
          out = 1'b1;
        end
        else begin
          next_state = 4'b0010; // Next state B
          out = 1'b0;
        end
      end
    endcase
  end
endmodule
