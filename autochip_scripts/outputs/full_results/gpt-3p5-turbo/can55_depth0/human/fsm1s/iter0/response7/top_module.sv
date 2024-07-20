module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b10;  // reset state B
        else begin
            case (state)
                2'b10: begin  // state B
                    if (in)
                        state <= 2'b10;
                    else
                        state <= 2'b01;  // transition to state A
                end
                2'b01: begin  // state A
                    if (in)
                        state <= 2'b01;
                    else
                        state <= 2'b10;  // transition to state B
                end
                default: state <= 2'b10;  // default to reset state B
            endcase
        end
    end
    
    assign out = (state == 2'b10) ? 1'b1 : 1'b0;  // assign output based on state B
    
endmodule
