module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

  reg [2:0] state;
  reg [7:0] received_byte;
  reg [2:0] bit_counter;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      received_byte <= 8'b0;
      bit_counter <= 3'b000;
      out_byte <= 8'b0;
      done <= 1'b0;
    end else begin
      case(state)
        3'b000: begin
          if (in == 1'b0) begin
            state <= 3'b001;
            received_byte <= 8'b0;
            bit_counter <= 3'b000;
          end
        end
        
        3'b001: begin
          if (bit_counter < 3'b111) begin
            received_byte <= {in, received_byte[7:1]};
            bit_counter <= bit_counter + 1;
          end else begin
            state <= 3'b010;
          end
        end
        
        3'b010: begin
          if (bit_counter == 3'b111) begin
            if (in == 1'b1) begin
              done <= 1'b1;
              out_byte <= received_byte;
            end
          end else begin
            state <= 3'b011;
          end
        end
        
        3'b011: begin
          if (in == 1'b1) begin
            if (bit_counter == 3'b111) begin
              done <= 1'b1;
              out_byte <= received_byte;
              state <= 3'b000;
            end
          end
        end
        
        default: state <= 3'b000;
      endcase
    end
  end
  
endmodule
