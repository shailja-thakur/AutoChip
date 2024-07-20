module top_module (
    input clk,
    input in,
    input reset,
    output out  
);
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b1;
        else begin
            case (state)
                2'b00: begin
                    if (in)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                end
                2'b01: begin
                    if (in)
                        state <= 2'b00;
                    else
                        state <= 2'b10;
                end
                2'b10: begin
                    if (in)
                        state <= 2'b11;
                    else
                        state <= 2'b01;
                end
                2'b11: begin
                    if (in)
                        state <= 2'b10;
                    else
                        state <= 2'b11;
                end
                default: state <= 2'b01;
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: out = 1;
            2'b01: out = 1;
            2'b10: out = 0;
            2'b11: out = 0;
            default: out = 1;
        endcase
    end

endmodule
