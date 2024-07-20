module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    // One-hot encoded state declarations
    reg state_A, state_B;
    reg [1:0] state;
    
    // State encoding
    localparam [1:0] A = 2'b01,
                     B = 2'b10;
    
    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // On reset, go to state A
        end else begin
            case (state)
                A: state <= (x) ? B : A;
                B: state <= (x) ? B : B;
                default: state <= A; // Default to state A for safety
            endcase
        end
    end
    
    // Output logic based on current state and input x
    assign z = (state == A) ? x : ~x;

endmodule
