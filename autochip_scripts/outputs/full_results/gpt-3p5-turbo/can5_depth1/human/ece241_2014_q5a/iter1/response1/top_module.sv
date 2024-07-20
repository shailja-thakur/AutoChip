module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

reg [1:0] state;
reg [1:0] nextState;
reg done;
reg [1:0] count;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
  if (areset) begin
    state <= 2'b00;
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
    2'b00: begin
      if (areset) begin
        nextState <= 2'b00;
        complement <= 0;
      end else if (x) begin
        nextState <= 2'b01;
        complement <= 0;
      end else begin
        nextState <= 2'b00;
        complement <= 0;
      end
    end
    
    2'b01: begin
      nextState <= 2'b10;
      complement <= ~complement;
    end
    
    2'b10: begin
      nextState <= 2'b00;
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
