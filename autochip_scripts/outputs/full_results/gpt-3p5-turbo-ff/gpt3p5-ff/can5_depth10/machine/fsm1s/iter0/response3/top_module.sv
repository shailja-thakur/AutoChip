module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b01;
        end else begin
            case (state)
                2'b01: if (in) state <= 2'b01; else state <= 2'b10;
                2'b10: if (in) state <= 2'b10; else state <= 2'b01;
            endcase
        end
    end
    
    assign out = (state == 2'b10) ? 1'b1 : 1'b0;
    
endmodule
