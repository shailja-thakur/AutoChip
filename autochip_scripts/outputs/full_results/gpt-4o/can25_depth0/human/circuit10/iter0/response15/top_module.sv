module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    
    always @(posedge clk) begin
        if (a & b) begin  // when both a and b are 1
            q <= state;
            state <= ~state;  // toggle state
        end
        else if (a) begin  // when a is 1
            state <= q;  // preserve previous q in state
        end
        else if (b) begin  // when b is 1
            q <= 1;  // set output q to 1
            state <= 0;  // reset state to 0
        end
        else begin
            state <= 0;  // reset state to 0
            q <= 0;  // reset q to 0
        end
    end
    
endmodule
