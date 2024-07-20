module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b0;
        else
            case (state)
                2'b00: begin
                    if (x == 1'b0)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                end
                2'b01: begin
                    if (x == 1'b0)
                        state <= 2'b01;
                    else
                        state <= 2'b10;
                end
                2'b10: begin
                    state <= 2'b10;
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    assign z = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
