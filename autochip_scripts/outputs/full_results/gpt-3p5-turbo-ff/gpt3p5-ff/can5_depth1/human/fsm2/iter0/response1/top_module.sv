module top_module (
	input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk, posedge areset) begin
        if (areset == 1'b1)
            state <= 2'b0;
        else begin
            case (state)
                2'b00: begin
                    if (j == 1'b0)
                        state <= 2'b00;
                    else if (j == 1'b1)
                        state <= 2'b01;
                end
                2'b01: begin
                    if (k == 1'b0)
                        state <= 2'b01;
                    else if (k == 1'b1)
                        state <= 2'b00;
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: out = 1'b0;
            2'b01: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
