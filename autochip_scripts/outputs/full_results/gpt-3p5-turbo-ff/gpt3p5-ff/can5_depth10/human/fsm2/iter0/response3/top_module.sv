module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg out;
    reg [1:0] state;
    
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
            out <= 1'b0;
        end else begin
            case (state)
                OFF: begin
                    if (j)
                        state <= ON;
                    else
                        state <= OFF;
                    out <= 1'b0;
                end
                ON: begin
                    if (k)
                        state <= OFF;
                    else
                        state <= ON;
                    out <= 1'b1;
                end
                default: state <= OFF;
            endcase
        end
    end
endmodule
