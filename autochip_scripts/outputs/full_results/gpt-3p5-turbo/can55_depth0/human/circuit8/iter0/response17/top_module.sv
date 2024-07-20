module top_module (
  input clock,
  input a, 
  output reg p,
  output reg q
);

reg [2:0] state;

always @(posedge clock) begin
  case (state)
    3'b000: begin
      if (a == 0) begin
        p <= 0;
        q <= 0;
        state <= 3'b000;
      end
      else begin
        p <= 0;
        q <= 0;
        state <= 3'b001;
      end
    end
    
    3'b001: begin
      if (a == 0) begin
        p <= 0;
        q <= 0;
        state <= 3'b001;
      end
      else begin
        p <= 0;
        q <= 0;
        state <= 3'b010;
      end
    end
    
    3'b010: begin
      if (a == 0) begin
        p <= 0;
        q <= 0;
        state <= 3'b010;
      end
      else begin
        p <= 0;
        q <= 0;
        state <= 3'b011;
      end
    end
    
    3'b011: begin
      if (a == 0) begin
        p <= 0;
        q <= 0;
        state <= 3'b011;
      end
      else begin
        p <= 0;
        q <= 0;
        state <= 3'b100;
      end
    end
    
    3'b100: begin
      if (a == 0) begin
        p <= 0;
        q <= 0;
        state <= 3'b100;
      end
      else begin
        p <= 0;
        q <= 0;
        state <= 3'b000;
      end
    end
  endcase
end

endmodule
