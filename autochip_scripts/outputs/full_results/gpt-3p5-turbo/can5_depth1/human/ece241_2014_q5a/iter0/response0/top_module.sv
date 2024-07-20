module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  reg [1:0] state;
  reg [1:0] nextState;
  reg done;
  reg [1:0] count;
  reg [7:0] complement;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00; // RESET state
      done <= 0;
      count <= 2'b00;
    end else begin
      state <= nextState;
      done <= 0;
      count <= count + 1;
    end
  end
  
  always @(state, x) begin
    case (state)
      2'b00: begin // IDLE state
        if (areset) begin
          nextState <= 2'b00;
          complement <= 0;
        end else if (x == 1'b1) begin
          nextState <= 2'b01; // CONVERT state
          complement <= 1;
        end else begin
          nextState <= 2'b00;
          complement <= 0;
        end
      end
      
      2'b01: begin // CONVERT state
        nextState <= 2'b10; // OUTPUT state
        complement <= ~complement;
      end
      
      2'b10: begin // OUTPUT state
        nextState <= 2'b00; // IDLE state
        complement <= 0;
        done <= 1;
      end
      
      default: begin
        nextState <= 2'b00;
        complement <= 0;
        done <= 0;
      end
    endcase
  end
  
  assign z = complement;
  
endmodule
