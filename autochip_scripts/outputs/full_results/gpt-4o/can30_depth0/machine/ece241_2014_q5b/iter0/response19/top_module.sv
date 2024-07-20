module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // Define the states using parameters
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // Declare state register
    reg state;
    
    // Sequential logic to update state based on clk and areset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Asynchronous reset
        else begin
            case (state)
                A: if (x) state <= B;
                   else state <= A;
                B: state <= B;
                default: state <= A;
            endcase
        end
    end

    // Combinational logic for output z
    assign z = ( (state == A) && x ) || ( (state == B) && !x );

endmodule
