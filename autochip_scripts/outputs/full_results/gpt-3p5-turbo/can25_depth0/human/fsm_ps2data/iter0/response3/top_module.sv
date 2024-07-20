module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

  reg [7:0] byte1;
  reg [7:0] byte2;
  reg [7:0] byte3;
  reg done_reg;

  always @(posedge clk or posedge reset) begin
    if (reset)
      begin
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done_reg <= 1'b0;
      end
    else
      begin
        if (done_reg && ~done)
          begin
            byte1 <= in;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done_reg <= 1'b0;
          end
        else
          if (done_reg && done)
            begin
              done_reg <= 1'b0;
            end
          else
            if (~done_reg && in[3] && ~(~byte1[7:4] == byte2[7:4] && ~byte2[7:4] == byte3[7:4] && ~byte3[7:4] == in[7:4]))
              begin
                byte1 <= in;
                byte2 <= in;
                byte3 <= in;
                done_reg <= 1'b1;
              end
            else
              if (~done_reg && ~in[3])
                begin
                  byte1 <= in;
                end
              else
                if (~done_reg && in[3] && ~(~byte1[7:4] == byte2[7:4] && ~byte2[7:4] == byte3[7:4] && ~byte3[7:4] == in[7:4]))
                  begin
                    byte2 <= in;
                  end
                else
                  if (~done_reg && in[3] && (~byte1[7:4] == byte2[7:4] && ~byte2[7:4] == byte3[7:4] && ~byte3[7:4] == in[7:4]))
                    begin
                      byte3 <= in;
                      done_reg <= 1'b1;
                    end
                  else
                    begin
                      byte1 <= in;
                    end
      end
  end

  assign out_bytes = {byte3, byte2, byte1};
  assign done = done_reg;

endmodule
