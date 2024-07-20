module top_module (
    input wire clk,
    input wire areset,
    input wire x,
    output wire z
);
    
    reg [1:0] state;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'bA;
        else
        begin
            case (state)
                2'bA: if (x) state <= 2'bB; else state <= 2'bA;
                2'bB: state <= 2'bB;
            endcase
        end
    end
    
    assign z = (state == 2'bA && x) || (state == 2'bB && !x);

endmodule
