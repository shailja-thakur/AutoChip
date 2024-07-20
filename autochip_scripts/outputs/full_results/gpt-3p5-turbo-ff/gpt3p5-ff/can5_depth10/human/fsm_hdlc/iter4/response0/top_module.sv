module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [3:0] state;

    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (in)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (in)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (in)
                        state <= S3;
                    else
                        state <= S0;
                end
                S3: begin
                    if (in)
                        state <= S2;
                    else
                        state <= S1;
                end
            endcase
        end
    end

    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S1: begin
                disc = 1;
            end
            S2: begin
                flag = 1;
            end
            S3: begin
                err = 1;
            end
        endcase
    end
endmodule
