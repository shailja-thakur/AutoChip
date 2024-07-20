module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire nextState;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= nextState;
end

assign nextState = (state == 3'b000 && w == 1'b0) ? 3'b001 :
                  (state == 3'b000 && w == 1'b1) ? 3'b000 :
                  (state == 3'b001 && w == 1'b1) ? 3'b011 :
                  (state == 3'b001 && w == 1'b0) ? 3'b010 :
                  (state == 3'b010 && w == 1'b1) ? 3'b011 :
                  (state == 3'b010 && w == 1'b0) ? 3'b100 :
                  (state == 3'b011 && w == 1'b1) ? 3'b000 :
                  (state == 3'b011 && w == 1'b0) ? 3'b101 :
                  (state == 3'b100 && w == 1'b1) ? 3'b011 :
                  (state == 3'b100 && w == 1'b0) ? 3'b100 :
                  (state == 3'b101 && w == 1'b1) ? 3'b011 :
                  (state == 3'b101 && w == 1'b0) ? 3'b010;
                  
assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
