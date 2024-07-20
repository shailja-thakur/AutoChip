module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg state, next_state;

    // State encoding
    localparam A = 1'b0;
    localparam B = 1'b1;
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else 
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == B);

endmodule
