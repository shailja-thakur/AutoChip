module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg d;
always @(posedge clk) begin
    case(state)
        0: begin
            if(a == 0 && b == 0)
                d = 0;
            else if(a == 0 && b == 1)
                d = 1;
        end
        1: begin
            if(a == 1 && b == 0)
                d = 1;
            else if(a == 1 && b == 1)
                d = 0;
        end
    endcase
    
    q <= d;
    state <= d;
end

endmodule
