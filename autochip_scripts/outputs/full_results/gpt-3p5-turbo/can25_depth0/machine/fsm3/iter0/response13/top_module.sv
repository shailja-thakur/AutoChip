module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // reset to state A
        else
            case (state)
                2'b00: state <= (in) ? 2'b01 : 2'b00; // A -> B if in=1, A -> A if in=0
                2'b01: state <= (in) ? 2'b01 : 2'b10; // B -> B if in=1, B -> C if in=0
                2'b10: state <= (in) ? 2'b11 : 2'b00; // C -> D if in=1, C -> A if in=0
                2'b11: state <= (in) ? 2'b01 : 2'b10; // D -> B if in=1, D -> C if in=0
            endcase
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output out = 1 if state is D, otherwise 0

endmodule
