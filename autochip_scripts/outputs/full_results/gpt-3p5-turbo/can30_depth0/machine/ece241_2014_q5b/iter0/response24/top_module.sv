module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    
    always @(posedge clk or negedge areset) begin
        if (!areset)
            state <= A;
        else begin
            case (state)
                A: if (x) state <= B; else state <= A;
                B: state <= B;
            endcase
        end
    end
    
    assign z = (state == A && x) || (state == B && !x);
    
endmodule
