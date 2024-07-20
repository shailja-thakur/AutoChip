module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 1'b0;
        end else begin
            if (state == 1'b0) begin
                if (in) begin
                    state <= 1'b0;
                end else begin
                    state <= 1'b1;
                end
            end else begin
                if (in) begin
                    state <= 1'b1;
                end else begin
                    state <= 1'b0;
                end
            end
        end
    end
    
    assign out = state;
    
endmodule
