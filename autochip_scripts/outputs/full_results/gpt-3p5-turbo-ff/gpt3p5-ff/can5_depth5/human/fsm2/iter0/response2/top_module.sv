module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    
    reg [1:0] state;
    always @(posedge clk, negedge areset) begin
        if (areset)
            state <= 2'b0;
        else begin
            case(state)
                2'b00: begin // OFF
                    if (j)
                        state <= 2'b01; // ON
                    else
                        state <= 2'b00; // OFF
                end
                2'b01: begin // ON
                    if (k)
                        state <= 2'b00; // OFF
                    else
                        state <= 2'b01; // ON
                end
                default: state <= 2'b0;
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
