module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    parameter A = 1;
    parameter B = 2;
    
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else begin
            case (state)
                A: begin
                    if (x)
                        state <= B;
                end
                B: begin
                    state <= B;
                end
            endcase
        end
    end
    
    assign z = (state == A && x) || (state == B && !x);
    
endmodule
