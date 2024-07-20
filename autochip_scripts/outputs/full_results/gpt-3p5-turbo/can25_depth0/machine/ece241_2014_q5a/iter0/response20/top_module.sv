module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else begin
            case (state)
                A: if (x)
                    state <= C;
                   else
                    state <= A;
                B: if (x)
                    state <= B;
                   else
                    state <= C;
                C: if (x)
                    state <= B;
                   else
                    state <= C;
                default: state <= A;
            endcase
        end
    end
    
    assign z = (state == C) ? 1'b1 : 1'b0;
endmodule
