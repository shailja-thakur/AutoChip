module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

  reg [3:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
    end else begin
      case (state)
        4'b0000: begin
          if (s == 3'b000) begin
            state <= 4'b0001;
          end else if (s == 3'b001) begin
            state <= 4'b0010;
          end else if (s == 3'b010) begin
            state <= 4'b0011;
          end else if (s == 3'b011) begin
            state <= 4'b0100;
          end
        end
        
        4'b0001: begin
          fr1 <= 1'b0;
          fr2 <= 1'b0;
          fr3 <= 1'b0;
          dfr <= 1'b0;
          if (s == 3'b001) begin
            state <= 4'b0010;
          end
        end
        
        4'b0010: begin
          fr1 <= 1'b1;
          fr2 <= 1'b0;
          fr3 <= 1'b0;
          dfr <= 1'b0;
          if (s == 3'b010) begin
            state <= 4'b0011;
          end else if (s == 3'b000) begin
            state <= 4'b0001;
          end
        end
        
        4'b0011: begin
          fr1 <= 1'b1;
          fr2 <= 1'b1;
          fr3 <= 1'b0;
          dfr <= 1'b0;
          if (s == 3'b001) begin
            state <= 4'b0100;
          end else if (s == 3'b000) begin
            state <= 4'b0001;
          end
        end
        
        4'b0100: begin
          fr1 <= 1'b1;
          fr2 <= 1'b1;
          fr3 <= 1'b1;
          dfr <= 1'b1;
          if (s == 3'b000) begin
            state <= 4'b0001;
          end
        end
        
      endcase
    end
  end

endmodule
