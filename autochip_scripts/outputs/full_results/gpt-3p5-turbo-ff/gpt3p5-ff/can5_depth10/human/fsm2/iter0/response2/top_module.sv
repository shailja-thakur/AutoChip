module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b0;
        else begin
            case (state)
                2'b00: begin
                    if (j)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end
                2'b01: begin
                    if (k)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                end
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
