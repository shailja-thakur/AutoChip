module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // state A
        else
            case (state)
                2'b00: begin // state A
                    if (x)
                        state <= 2'b01; // state B
                    else
                        state <= 2'b00; // state A
                end
                2'b01: begin // state B
                    if (x)
                        state <= 2'b10; // state B
                    else
                        state <= 2'b01; // state B
                end
                default: begin
                    state <= 2'b00; // state A
                end
            endcase
    end
    
    always @(state, x) begin
        case (state)
            2'b00: z = 1'b0; // state A
            2'b01: z = 1'b1; // state B
            default: z = 1'b0; // state A
        endcase
    end
endmodule
