module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;

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
                        state <= S2;
                end
                S3: begin
                    if (in)
                        state <= S3;
                    else
                        state <= S0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            S0: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
            S1: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
            S2: begin
                disc = 1;
                flag = 0;
                err = 0;
            end
            S3: begin
                disc = 0;
                flag = 1;
                err = 1;
            end
        endcase
    end
endmodule
