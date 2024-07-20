module top_module(
   input clk,
   input reset,
   input data,
   output start_shifting);
   
   reg [2:0] state; // register to hold the current state of the state machine
   
   always @(posedge clk) begin // update the state machine on the rising edge of clk
      if (reset) begin
         state <= 3'b000; // reset to initial state S
      end else begin
         case (state)
            3'b000: begin
               if (data) begin
                  state <= 3'b001; // transition to state S1 if data input is high
               end else begin
                  state <= 3'b000; // stay in state S if data input is low
               end
            end
            3'b001: begin
               if (data) begin
                  state <= 3'b011; // transition to state S11 if data input is high
               end else begin
                  state <= 3'b000; // back to state S if data input is low
               end
            end
            3'b011: begin
               if (data) begin
                  state <= 3'b011; // stay in state S11 if data input is high
               end else begin
                  state <= 3'b110; // transition to state S110 if data input is low
               end
            end
            3'b110: begin
               if (data) begin
                  state <= 3'b111; // transition to state Done if data input is high
               end else begin
                  state <= 3'b000; // back to state S if data input is low
               end
            end
            3'b111: begin
               state <= 3'b111; // stay in state Done
            end
         endcase
      end
   end
   
   assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0; // assign output based on current state
   
endmodule
