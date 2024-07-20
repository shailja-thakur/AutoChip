module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (areset == 1'b1)
            state <= 2'b01; // reset to state B
        else begin
            case (state)
                2'b00: state <= (in == 1'b1) ? 2'b00 : 2'b01; // state A
                2'b01: state <= (in == 1'b1) ? 2'b01 : 2'b00; // state B
                default: state <= 2'b01; // default to state B
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
