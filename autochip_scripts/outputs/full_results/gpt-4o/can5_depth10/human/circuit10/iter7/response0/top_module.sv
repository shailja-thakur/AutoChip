module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg next_state;
    reg next_q;
    
    always @(posedge clk) begin
        state <= next_state;
        q <= next_q;
    end
    
    always @(*) begin
        next_state = state;
        next_q = q;
        
        if (a == 1 && b == 1) begin
            next_state = ~state;
            next_q = state;
        end
        else if (a == 1 && b == 0) begin
            next_state = state;
            next_q = 1;
        end
        else if (a == 0 && b == 1) begin
            next_state = 0;
            next_q = 1;
        end
        else begin
            next_state = 0;
            next_q = 0;
        end
    end
    
endmodule
