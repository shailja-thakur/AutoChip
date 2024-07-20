module top_module (
    input wire clk,
    input wire areset,
    input wire x,
    output wire z
);
    
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (areset)
            state <= A;
        else begin
            case (state)
                A: state <= (x) ? B : A;
                B: state <= B;
            endcase
        end
    end
    
    assign z = (state == A && x) || (state == B && !x);
        
endmodule
