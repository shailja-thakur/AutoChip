module top_module (
    input clk,
    input a,
    input b,
    output reg q,      // Declaring q as reg since it holds the output of the flip-flop
    output reg state   // Declaring state as reg since it holds the state of the system
);
    
    always @(posedge clk) begin
        if (a & b)
            state <= ~state;
        else if (~a & b)
            state <= 1;
        else if (a & ~b)
            state <= 0;
    end
    
    always @(posedge clk) begin
        q <= state;
    end

endmodule
