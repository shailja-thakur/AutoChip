module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q;
reg state;

always @(posedge clk) begin
    state <= state;
    case(state)
        0: begin
            if(a == 0 && b == 0)
                q <= 0;
            else if(a == 1 && b == 0)
                q <= 1;
            else if(a == 0 && b == 1)
                q <= 0;
            else if(a == 1 && b == 1)
                q <= 1;
            else
                q <= q;
            state <= 1;
        end
        1: begin
            if(a == 0 && b == 0)
                q <= 0;
            else if(a == 1 && b == 0)
                q <= 1;
            else if(a == 0 && b == 1)
                q <= 0;
            else if(a == 1 && b == 1)
                q <= 1;
            else
                q <= q;
            state <= 0;
        end
    endcase
end

endmodule
