module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;
    parameter A = 2'b00;
    parameter B = 2'b01;
    
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else begin
            if (state == A) begin
                if (in)
                    state <= A;
                else
                    state <= B;
            end else begin // state == B
                if (in)
                    state <= B;
                else
                    state <= A;
            end
        end
    end
    
    always @(state) begin
        if (state == B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end
    
endmodule
