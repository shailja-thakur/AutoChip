module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);
    reg current_state;
    
    always @(posedge clk) begin
        if (a == 1 & b == 1) begin
            current_state <= ~current_state;
        end else begin
            current_state <= b;
        end
    end
    
    assign state = current_state;
    assign q = current_state;

endmodule
