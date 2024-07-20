module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // reset to state A
        end else begin
            case (state)
                2'b00: if (in) state <= 2'b01; else state <= 2'b00; // A -> B if in is 1, A -> A if in is 0
                2'b01: if (in) state <= 2'b01; else state <= 2'b10; // B -> B if in is 1, B -> C if in is 0
                2'b10: if (in) state <= 2'b11; else state <= 2'b00; // C -> D if in is 1, C -> A if in is 0
                2'b11: if (in) state <= 2'b01; else state <= 2'b10; // D -> B if in is 1, D -> C if in is 0
                default: state <= 2'b00; // default case, reset to state A
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // set out to 1 if state is D, otherwise set to 0
    
endmodule
