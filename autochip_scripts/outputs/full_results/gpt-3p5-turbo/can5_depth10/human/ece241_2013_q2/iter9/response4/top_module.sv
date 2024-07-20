module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

   always @* begin
       case ({a, b, c, d})
           4'b0010, 4'b0111, 4'b1111: begin
               out_sop = 1;
               out_pos = 1;
           end
           4'b0000, 4'b0001, 4'b0100, 4'b0101, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: begin
               out_sop = 0;
               out_pos = 0;
           end
           default: begin
               out_sop = 0;
               out_pos = 0;
           end
       endcase
   end

endmodule
