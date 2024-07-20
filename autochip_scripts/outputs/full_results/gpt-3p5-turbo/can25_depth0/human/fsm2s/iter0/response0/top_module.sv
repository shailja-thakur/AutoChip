module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= 2'b0;
        else begin
            case(state)
                2'b00:
                    if(j)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                2'b01:
                    if(k)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                default:
                    state <= 2'b00;
            endcase
        end
    end
    
    always @* begin
        case(state)
            2'b00:
                out = 1'b0;
            2'b01:
                out = 1'b1;
            default:
                out = 1'b0;
        endcase
    end

endmodule
