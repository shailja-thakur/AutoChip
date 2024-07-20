module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State encoding using one-hot encoding
    reg [1:0] state;
    reg [1:0] next_state;
    localparam A = 2'b01;
    localparam B = 2'b10;
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    assign z = (state == A) ? x : ~x;

endmodule
