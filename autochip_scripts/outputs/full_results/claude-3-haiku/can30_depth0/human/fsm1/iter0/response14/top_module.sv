module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [0:0] state, next_state;
    
    // State encodings
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State transitions
    always @(*) begin
        case (state)
            A: begin
                if (in == 1'b0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (in == 1'b0) next_state = B;
                else next_state = A;
            end
        endcase
    end
    
    // State register
    always @(posedge clk, posedge areset) begin
        if (areset) state <= B;
        else state <= next_state;
    end
    
    // Output logic
    assign out = state;

endmodule
