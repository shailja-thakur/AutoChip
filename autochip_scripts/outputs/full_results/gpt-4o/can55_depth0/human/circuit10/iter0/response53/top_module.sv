module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
    reg next_state;
    
    always @(*) begin
        if (a && b) begin
            next_state = !state;
        end else if (!a && b) begin
            next_state = state;
        end else if (a && !b) begin
            next_state = state;
        end else begin
            next_state = state;
        end
    end
    
    always @(posedge clk) begin
        state <= next_state;
        q <= state;
    end

endmodule
