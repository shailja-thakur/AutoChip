module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    reg [1:0] next_state;

    always @(*) begin
        if (state == A)
            next_state = (j == 1) ? B : A;
        else if (state == B)
            next_state = (k == 1) ? A : B;
    end

    always @(posedge clk) begin
        if (areset == 1'b1)
            state <= A;
        else
            state <= next_state;
    end

    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
