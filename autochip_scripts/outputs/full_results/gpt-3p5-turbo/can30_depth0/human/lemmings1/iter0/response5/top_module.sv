module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
   reg [1:0] state;  // current state
   
   always @(posedge clk or posedge areset) begin
       if (areset) begin
           state <= 2'b01;  // initialize state to walk_left
       end else begin
           case (state)
               2'b01: begin  // state walk_left
                   if (bump_right) begin
                       state <= 2'b10;  // switch to state walk_right
                   end
               end
               2'b10: begin  // state walk_right
                   if (bump_left) begin
                       state <= 2'b01;  // switch to state walk_left
                   end
               end
           endcase
       end
   end
   
   // Output generation
   assign walk_left = (state == 2'b01);
   assign walk_right = (state == 2'b10);
   
endmodule
