module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

  reg [2:0] state;
  reg [23:0] register;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset) 
    begin
      state <= BYTE1;
      register <= 0;
    end
    else
    begin
      case (state)
        BYTE1:
        begin
          if (in[2] == 1)
            state <= BYTE2;
          else
            state <= BYTE1;
          register <= (register << 8) | in;
        end
        
        BYTE2:
        begin
          state <= BYTE3;
          register <= (register << 8) | in;
        end
        
        BYTE3:
        begin
          state <= DONE;
          register <= (register << 8) | in;
        end
        
        DONE:
        begin
          if (in[2] == 0)
            state <= BYTE1;
          else
            state <= DONE;
          register <= (register << 8) | in;
        end
      endcase
    end
  end
  
  assign out_bytes = (done == 1) ? register : 0;
  assign done = (state == DONE) ? 1 : 0;
  
endmodule
