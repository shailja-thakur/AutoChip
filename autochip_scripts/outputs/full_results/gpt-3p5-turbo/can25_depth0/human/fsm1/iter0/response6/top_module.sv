module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;
wire next_state;

parameter B = 0;
parameter A = 1;

always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= B;
    else
        state <= next_state;
end

always @*
begin
    case (state)
        B: begin
               if (in)
                   next_state = B;
               else
                   next_state = A;
           end
        
        A: begin
               if (in)
                   next_state = A;
               else
                   next_state = B;
           end
           
        default: next_state = B;
    endcase
end

assign out = state;

endmodule
