module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    reg [2:0] state;
    reg prev_areset;

    parameter S0 = 3'b011;
    parameter S1 = 3'b001;
    parameter S2 = 3'b110;
    parameter S3 = 3'b000;

    always @(posedge clk or negedge areset)
    begin
        if (areset)
        begin
            state <= S0;
            prev_areset <= areset;
        end
        else if (prev_areset)
        begin
            state <= S0;
            prev_areset <= areset;
        end
        else
        begin
            case(state)
                S0: begin
                    if (x)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (x)
                        state <= S1;
                    else
                        state <= S2;
                end
                S2: begin
                    if (x)
                        state <= S1;
                    else
                        state <= S3;
                end
                S3: begin
                    if (areset)
                        state <= S0;
                    else
                        state <= S3;
                end
            endcase
            prev_areset <= areset;
        end
    end

    always @(state)
    begin
        case(state)
            S0: z <= 1'b0;
            S1: z <= ~x + 1;
            S2: z <= ~x + 1;
            S3: z <= ~x;
        endcase
    end
endmodule
