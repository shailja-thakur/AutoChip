module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

   reg [3:0] state;
   reg prev_data;
   reg [1:0] count;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 4'b0000;
         count <= 2'b00;
         start_shifting <= 1'b0;
      end
      else begin
         case (state)
            4'b0000: begin
               if (data == 1'b1) begin
                  state <= 4'b0001;
                  prev_data <= 1'b1;
               end
               else begin
                  state <= 4'b0000;
                  prev_data <= 1'b0;
               end
            end
            4'b0001: begin
               if (data == 1'b1) begin
                  state <= 4'b0010;
                  prev_data <= 1'b1;
               end
               else begin
                  state <= 4'b0000;
                  prev_data <= 1'b0;
               end
            end
            4'b0010: begin
               if (data == 1'b0) begin
                  state <= 4'b0011;
                  prev_data <= 1'b0;
               end
               else begin
                  state <= 4'b0000;
                  prev_data <= 1'b0;
               end
            end
            4'b0011: begin
               if (data == 1'b0) begin
                  count <= count + 1'b1;
                  prev_data <= 1'b0;
                  if (count == 2'b10) begin
                     state <= 4'b0100;
                     start_shifting <= 1'b1;
                  end
                  else begin
                     state <= 4'b0000;
                  end
               end
               else begin
                  state <= 4'b0000;
                  prev_data <= 1'b0;
               end
            end
            4'b0100: begin
               state <= 4'b0100;
               if (reset) begin
                  start_shifting <= 1'b0;
               end
            end
         endcase
      end
   end

endmodule
