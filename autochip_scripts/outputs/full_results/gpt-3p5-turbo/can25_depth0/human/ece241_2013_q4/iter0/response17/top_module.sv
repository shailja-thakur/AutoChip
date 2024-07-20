module top_module(
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
   
   reg [3:1] prev_s;

   always @(posedge clk) begin
      if (reset) begin
         prev_s <= 3'b000;  // Set prev_s to lowest water level
         fr3 <= 1'b1;  // Assert fr3 since water level is low
         fr2 <= 1'b1;  // Assert fr2 since water level is low
         fr1 <= 1'b1;  // Assert fr1 since water level is low
         dfr <= 1'b0;  // Clear dfr valve
      end else begin
         case({prev_s, s})
            4'b1110: begin
               fr3 <= 1'b0;
               fr2 <= 1'b0;
               fr1 <= 1'b0;
               dfr <= 1'b0;
            end
            4'b1100: begin
               fr3 <= 1'b0;
               fr2 <= 1'b0;
               fr1 <= 1'b1;
               dfr <= 1'b0;
            end
            4'b1000: begin
               fr3 <= 1'b0;
               fr2 <= 1'b1;
               fr1 <= 1'b1;
               dfr <= 1'b0;
            end
            4'b0000: begin
               fr3 <= 1'b1;
               fr2 <= 1'b1;
               fr1 <= 1'b1;
               dfr <= 1'b1;
            end
            default: begin
               fr3 <= 1'b1;
               fr2 <= 1'b1;
               fr1 <= 1'b1;
               dfr <= 1'b0;
            end
         endcase
         prev_s <= s;
      end
   end

endmodule
