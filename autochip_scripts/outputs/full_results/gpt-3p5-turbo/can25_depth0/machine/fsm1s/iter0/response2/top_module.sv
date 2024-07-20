module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b10; // initial state is B
        end else begin
            case (state)
                2'b01: begin
                    state <= (in) ? 2'b01 : 2'b10;
                end
                2'b10: begin
                    state <= (in) ? 2'b10 : 2'b01;
                end
                default: begin
                    state <= 2'b10;
                end
            endcase
        end
    end
    
    assign out = (state == 2'b10) ? 1'b1 : 1'b0;
    
endmodule
