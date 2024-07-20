module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else begin
            case(state)
                A: begin
                    if (x)
                        state <= B;
                    else
                        state <= A;    
                end
                B: state <= B;
            endcase
        end
    end
    
    always @(state or x) begin
        if (state == A && x || state == B && !x)
            z = 1'b1;
        else
            z = 1'b0;
    end
endmodule
