module top_module(
	input clk,
	input reset,
	output shift_ena);

  reg [3:0] state;
  parameter [3:0] S0 = 4'b0000;
  parameter [3:0] RST = 4'b0001;
  parameter [3:0] S1 = 4'b0010;
  parameter [3:0] S2 = 4'b0100;
  parameter [3:0] S3 = 4'b1000;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= RST;
    end else begin
	  case (state) 
	    S0: begin
		  state <= S1;
	    end
            
	    S1: begin
		  state <= S2;
	    end
            
	    S2: begin
		  state <= S3;
	    end

	    S3: begin
		  state <= S0;
	    end
	  endcase
    end
  end
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_ena <= 1'b0;
    end else if(state == S0) begin
      shift_ena <= 1'b1;
    end else begin
      shift_ena <= 1'b0;
    end
  end
endmodule
