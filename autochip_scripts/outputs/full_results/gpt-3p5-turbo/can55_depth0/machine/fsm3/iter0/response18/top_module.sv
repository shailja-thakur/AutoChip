module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;  // 2-bit state register

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;  // reset state to A
        else begin
            case (state)
                2'b00: state <= (in) ? 2'b10 : 2'b00;  // A -> B if in = 1, else A -> A
                2'b01: state <= (in) ? 2'b01 : 2'b10;  // B -> B if in = 1, else B -> C
                2'b10: state <= (in) ? 2'b11 : 2'b00;  // C -> D if in = 1, else C -> A
                2'b11: state <= (in) ? 2'b01 : 2'b10;  // D -> B if in = 1, else D -> C
            endcase
        end
    end
    
    assign out = (state == 2'b11);  // set out to 1 when state is D
    
endmodule
