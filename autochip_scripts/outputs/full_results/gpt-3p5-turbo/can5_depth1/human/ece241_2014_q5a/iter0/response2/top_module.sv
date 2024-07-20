module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    reg z;
    reg temp;
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= 0;
            z <= 0;
            temp <= 0;
        end
        else begin
            case (state)
                0: begin
                    if (x == 1'b0)
                        state <= 1;
                    else
                        state <= 2;
                end
                
                1: begin
                    if (x == 1'b1)
                        state <= 0;
                end
                
                2: begin
                    temp <= ~x;
                    state <= 3;
                end
                
                3: begin
                    z <= temp;
                    state <= 1;
                end
            endcase
        end
    end
    
endmodule
