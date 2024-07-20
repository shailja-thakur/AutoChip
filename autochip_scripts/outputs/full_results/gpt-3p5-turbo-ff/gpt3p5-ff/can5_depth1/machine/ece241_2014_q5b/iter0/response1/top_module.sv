module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
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
                default: begin
                    state <= A;
                end
            endcase
        end
    end
    
    assign z = (state == A && x) || (state == B && !x);

endmodule
