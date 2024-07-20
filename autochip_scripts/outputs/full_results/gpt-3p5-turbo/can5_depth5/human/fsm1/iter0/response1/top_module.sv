module top_module (
    input clk,
    input in,
    input areset,
    output out
);
 
reg [1:0] state, next_state;
 
parameter A = 2'b00;
parameter B = 2'b01;
 
always @(posedge clk or posedge areset)
if (areset)
    state <= B;
else
    state <= next_state;
 
always @(*)
case (state)
    A: begin
        if (in)
            next_state = A;
        else
            next_state = B;
        out = 0;
    end
    B: begin
        if (in)
            next_state = B;
        else
            next_state = A;
        out = 1;
    end
endcase
 
endmodule
