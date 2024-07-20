module top_module (
   input clk,
   input reset,
   input [3:1] s,
   output reg fr3,
   output reg fr2,
   output reg fr1,
   output reg dfr
);

reg [3:1] prev_s;
reg [1:0] state;

// states
parameter IDLE = 2'b00;
parameter ABOVE_S3 = 2'b01;
parameter BETWEEN_S3_S2 = 2'b10;
parameter BETWEEN_S2_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
   if (reset) begin
      state <= IDLE;
      prev_s <= 3'b000;
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      dfr <= 1'b1;
   end else begin
      case (state)
         IDLE: begin
            if (s[3] == 1'b1) begin
               state <= ABOVE_S3;
            end else if (s[2] == 1'b1) begin
               state <= BETWEEN_S3_S2;
            end else if (s[1] == 1'b1) begin
               state <= BETWEEN_S2_S1;
            end else begin
               state <= IDLE;
            end
         end
         ABOVE_S3: begin
            if (s[3] == 1'b0) begin
               state <= BETWEEN_S3_S2;
            end
         end
         BETWEEN_S3_S2: begin
            if (s[2] == 1'b0) begin
               state <= BETWEEN_S2_S1;
            end else if (s[3] == 1'b1) begin
               state <= ABOVE_S3;
            end
         end
         BETWEEN_S2_S1: begin
            if (s[1] == 1'b0) begin
               state <= IDLE;
            end else if (s[2] == 1'b1) begin
               state <= BETWEEN_S3_S2;
            end
         end
      endcase
   end
end

always @(*) begin
   case (state)
      IDLE: begin
         fr3 <= 1'b1;
         fr2 <= 1'b1;
         fr1 <= 1'b1;
         dfr <= 1'b1;
      end
      ABOVE_S3: begin
         fr3 <= 1'b0;
         fr2 <= 1'b0;
         fr1 <= 1'b0;
         dfr <= 1'b0;
      end
      BETWEEN_S3_S2: begin
         fr3 <= 1'b0;
         fr2 <= 1'b0;
         fr1 <= 1'b1;
         dfr <= 1'b0;
      end
      BETWEEN_S2_S1: begin
         fr3 <= 1'b0;
         fr2 <= 1'b1;
         fr1 <= 1'b1;
         if (s[1] == 1'b0 && prev_s[1] == 1'b1) begin
            dfr <= 1'b1;
         end else begin
            dfr <= 1'b0;
         end
      end
   endcase
end

always @(posedge clk) begin
   prev_s <= s;
end

endmodule
