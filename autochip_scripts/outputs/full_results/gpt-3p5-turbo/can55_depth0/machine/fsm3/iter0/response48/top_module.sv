module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 2'b00; // Reset to state A
        end else begin
            case (state)
                2'b00: state <= (in) ? 2'b01 : 2'b00; // Next state is B if input is 1, else A
                2'b01: state <= (in) ? 2'b01 : 2'b10; // Next state is B if input is 1, else C
                2'b10: state <= (in) ? 2'b11 : 2'b00; // Next state is D if input is 1, else A
                2'b11: state <= (in) ? 2'b01 : 2'b10; // Next state is B if input is 1, else C
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output is 1 when state is D
    
endmodule
