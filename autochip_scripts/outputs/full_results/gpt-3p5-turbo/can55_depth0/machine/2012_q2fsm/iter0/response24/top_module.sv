module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // initial state A
        end else begin
            case ({state, w})
                2'b00: state <= 3'b000; // A -> A
                2'b01: state <= 3'b001; // A -> B
                2'b10: state <= 3'b010; // B -> C
                2'b11: state <= 3'b100; // C -> E
                2'b01: state <= 3'b110; // D -> F
                2'b10: state <= 3'b100; // E -> E
                2'b10: state <= 3'b010; // F -> C
                default: state <= state; // No change
            endcase
        end
    end
    
    assign z = (state == 3'b100) || (state == 3'b110);

endmodule
