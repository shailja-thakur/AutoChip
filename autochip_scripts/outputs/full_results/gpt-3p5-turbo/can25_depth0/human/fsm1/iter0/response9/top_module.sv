module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire [1:0] next_state;
    
    // Define states
    parameter B = 2'b00;
    parameter A = 2'b01;
    
    // Define outputs
    wire out_b = (state == B) ? 1'b1 : 1'b0;
    wire out_a = (state == A) ? 1'b1 : 1'b0;
    assign out = out_b;
    
    // Next state logic
    always @(*) begin
        case (state)
            B: begin
                if (areset) next_state = B;
                else if (in) next_state = A;
                else next_state = B;
            end
            
            A: begin
                if (areset) next_state = B;
                else if (in) next_state = A;
                else next_state = B;
            end
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) state <= B;
        else state <= next_state;
    end
endmodule
