module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state;
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= 2'b00; // Reset state
        else begin
            case (state)
                2'b00: if (x)
                            state <= 2'b01;
                        else
                            state <= 2'b00;
                    
                2'b01: if (x)
                            state <= 2'b10;
                        else
                            state <= 2'b00;
                    
                2'b10: if (x)
                            state <= 2'b01;
                        else
                            state <= 2'b00;
                            
                default: state <= 2'b00;
            endcase
        end
    end
    
    always @(state, x) begin
        case(state)
            2'b10: z = 1'b1; // 101 sequence detected
            default: z = 1'b0; // No sequence detected
        endcase
    end
endmodule
