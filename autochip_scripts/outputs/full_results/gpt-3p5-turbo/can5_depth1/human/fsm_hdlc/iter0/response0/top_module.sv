module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

  reg [2:0] state;
  reg [2:0] next_state;
  
  parameter [2:0] IDLE = 3'b000;
  parameter [2:0] BIT5 = 3'b001;
  parameter [2:0] BIT6 = 3'b010;
  parameter [2:0] BIT7 = 3'b011;
  
  always @(posedge clk, posedge reset) begin
    if(reset) begin
      state <= IDLE;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      state <= next_state;
      case(state)
        IDLE: begin
          if(in) begin
            next_state <= BIT5;
          end else begin
            next_state <= IDLE;
          end
        end
        BIT5: begin
          if(in) begin
            next_state <= BIT6;
            disc <= 1;
          end else begin
            next_state <= IDLE;
            disc <= 0;
          end
        end
        BIT6: begin
          if(in) begin
            next_state <= BIT7;
            flag <= 1;
          end else begin
            next_state <= IDLE;
            flag <= 0;
          end
        end
        BIT7: begin
          if(in) begin
            next_state <= BIT7;
            err <= 1;
          end else begin
            next_state <= IDLE;
            err <= 0;
          end
        end
        default: begin
          next_state <= IDLE;
        end
      endcase
    end
  end
  
endmodule
