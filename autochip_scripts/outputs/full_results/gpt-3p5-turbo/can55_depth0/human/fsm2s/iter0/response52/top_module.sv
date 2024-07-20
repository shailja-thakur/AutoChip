module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

   reg [1:0] state;
   wire next_out;

   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 2'b0;
      else
         case (state)
            2'b00: begin // OFF state
               if (j)
                  state <= 2'b01; // Transition to ON state if j=1
               else
                  state <= 2'b00; // Stay in OFF state if j=0
            end
            2'b01: begin // ON state
               if (k)
                  state <= 2'b00; // Transition to OFF state if k=1
               else
                  state <= 2'b01; // Stay in ON state if k=0
            end
            default: state <= 2'b00; // Default state is OFF state
         endcase
      end
   
   assign out = (state == 2'b01) ? 1'b1 : 1'b0;
   
endmodule
