module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);
  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset == 1'b1) begin
      state <= 3'b000;
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      dfr <= 1'b1;
    end else begin
      case (state)
        3'b000: begin
          if (s[3] == 1'b1) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
          end else if (s[2] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b010;
          end else if (s[1] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b001;
          end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b000;
          end
        end
        
        3'b001: begin
          if (s[3] == 1'b1) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
          end else if (s[2] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b010;
          end else if (s[1] == 1'b0) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            state <= 3'b100;
          end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b001;
          end
        end
        
        3'b010: begin
          if (s[3] == 1'b1) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
          end else if (s[2] == 1'b0) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            state <= 3'b101;
          end else if (s[1] == 1'b0) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b011;
          end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b010;
          end
        end
        
        3'b011: begin
          if (s[3] == 1'b1) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
          end else if (s[2] == 1'b0) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            state <= 3'b101;
          end else if (s[1] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b001;
          end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b011;
          end
        end
        
        3'b100: begin
          if (s[3] == 1'b1) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
          end else if (s[2] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b010;
          end else if (s[1] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b001;
          end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b100;
          end
        end
        
        3'b101: begin
          if (s[3] == 1'b1) begin
            fr3 <= 1'b0;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b000;
          end else if (s[2] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b0;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b010;
          end else if (s[1] == 1'b1) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b0;
            dfr <= 1'b0;
            state <= 3'b001;
          end else begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b0;
            state <= 3'b101;
          end
        end
        
      endcase
    end
  end
  
endmodule
