module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            if (state == A) begin
                if (in) begin
                    state <= A;
                end else begin
                    state <= B;
                end
            end else if (state == B) begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
        end
    end
    
    assign out = (state == B) ? 1'b1 : 1'b0;
    
endmodule
