module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                    end else begin
                        state <= OFF;
                    end
                end
                
                ON: begin
                    if (k) begin
                        state <= OFF;
                    end else begin
                        state <= ON;
                    end
                end
            endcase
        end
    end
    
    assign out = (state == ON) ? 1'b1 : 1'b0;
    
endmodule
