module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    reg [1:0] state;
    reg [2:0] count;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (x == 1'b1)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (x == 1'b0)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (x == 1'b1)
                        state <= S1;
                    else if (x == 1'b0)
                        state <= S2;
                    else
                        state <= S0;
                end
                default: state <= S0;
            endcase
        end
    end

    always @(state) begin
        case (state)
            S2: begin
                count <= count + 1;
                if (count == 3)
                    z <= 1'b1;
                else
                    z <= 1'b0;
            end
            default: begin
                count <= 0;
                z <= 1'b0;
            end
        endcase
    end
endmodule
